//
//  Runner.swift
//  FolderWatch
//
//  Created by Oliver Michalak on 03.04.20.
//  Copyright © 2020 Oliver Michalak. All rights reserved.
//

import Foundation


protocol Runnable {
	func updated()
	func inform(_ text: String)
}

class Runner {
	
	init() {
		if isActive {
			start()
		}
	}
	
	var delegate: Runnable?

	@PreferenceStorage(key: "source", defaultValue: nil)
	var source: URL?
	
	@PreferenceStorage(key: "dest", defaultValue: nil)
	var dest: URL?
	
	@PreferenceStorage(key: "isActive", defaultValue: false)
	private(set) var isActive: Bool
	
	private var timer: Timer?
	
	func start() {
		guard source != nil, dest != nil else { return }
		
		timer?.invalidate()
		timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true, block: { [weak self] _ in
			self?.check()
		})
		isActive = true
		delegate?.updated()
		
		check()
	}
	
	func stop() {
		timer?.invalidate()
		timer = nil
		isActive = false
		delegate?.updated()
	}
	
	private func check() {
		guard let source = source, let dest = dest else { return }
		
		let fm = FileManager.default
		var list = [String]()
		do {
			list = try fm.contentsOfDirectory(atPath: source.path)
		}
		catch {
			delegate?.inform(error.localizedDescription)
			stop()
		}

		var moveList = [String]()
		let now = Date()
		// check all content
		for name in list {
			// ignore hidden files
			if name.hasPrefix(".") {
				continue
			}

			let sourcePath = source.appendingPathComponent(name)
			if let attr = try? fm.attributesOfItem(atPath: sourcePath.path) {
				
				// don't inspect busy files
				if let val = attr[FileAttributeKey.busy], (val as! NSNumber).boolValue {
					continue
				}
				
				// if last modification date is older than 1 minute, assume file is ready to move
				if let val = attr[FileAttributeKey.modificationDate] {
					let date = (val as! NSDate) as Date
					if date.addingTimeInterval(5 * 60) < now {
						moveList.append(name)
					}
				}
				//				let length = (attr[FileAttributeKey.size] as! NSNumber).uint64Value
			}
		}
		
		for name in moveList {
			let sourcePath = source.appendingPathComponent(name)
			let destPath = dest.appendingPathComponent(name)
			delegate?.inform("\"\(sourcePath.path)\" → \"\(destPath.path)\"")
			do {
				try fm.moveItem(at: sourcePath, to: destPath)
			}
			catch {
				delegate?.inform("...failed to move \"\(sourcePath.path)\" → \"\(destPath.path)\"")
			}
		}
	}
}


extension Runner {
	
	var sourceString: String {
		source == nil ? "/" : source!.path
	}
	
	var destString: String {
		dest == nil ? "/" : dest!.path
	}
}
