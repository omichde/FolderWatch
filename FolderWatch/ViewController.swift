//
//  ViewController.swift
//  FolderWatch
//
//  Created by Oliver Michalak on 03.04.20.
//  Copyright © 2020 Oliver Michalak. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
	
	@IBOutlet weak var sourceButton: NSButton!
	@IBOutlet weak var destButton: NSButton!
	@IBOutlet weak var startButton: NSButton!
	@IBOutlet weak var stopButton: NSButton!
	@IBOutlet weak var busyView: NSProgressIndicator!
	@IBOutlet var infoView: NSTextView!
	
	lazy var run: Runner = {
		let r = Runner()
		r.delegate = self
		return r
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		viewUpdate()
	}
	
	func viewUpdate() {
		sourceButton.title = run.sourceString
		destButton.title = run.destString
		if run.isActive {
			sourceButton.isEnabled = false
			destButton.isEnabled = false
			startButton.isHidden = true
			stopButton.isHidden = false
			busyView.isHidden = false
			busyView.startAnimation(nil)
		}
		else {
			sourceButton.isEnabled = true
			destButton.isEnabled = true
			startButton.isHidden = false
			stopButton.isHidden = true
			busyView.isHidden = true
			busyView.stopAnimation(nil)
		}
	}
	
	@IBAction func selectSource(_ sender: NSButton) {
		let panel = NSOpenPanel()
		panel.directoryURL = run.source
		panel.canChooseFiles = false
		panel.canChooseDirectories = true
		panel.beginSheetModal(for: view.window!) { response in
			if response == .OK, let url = panel.url {
				self.run.source = url
				self.viewUpdate()
			}
		}
	}
	
	@IBAction func selectDest(_ sender: NSButton) {
		let panel = NSOpenPanel()
		panel.directoryURL = run.dest
		panel.canChooseFiles = false
		panel.canChooseDirectories = true
		panel.beginSheetModal(for: view.window!) { response in
			if response == .OK, let url = panel.url {
				self.run.dest = url
				self.viewUpdate()
			}
		}
	}
	
	@IBAction func start(_ sender: NSButton) {
		infoView.string = ""
		run.start()
		viewUpdate()
	}
	
	@IBAction func stop(_ sender: NSButton) {
		run.stop()
		viewUpdate()
	}
}


extension ViewController: Runnable {
	
	func updated() {
		viewUpdate()
	}
	
	func inform(_ text: String) {
		var list = infoView.string.components(separatedBy: "\n")
		list.append(text)
		infoView.string = list.joined(separator: "\n")
	}
}
