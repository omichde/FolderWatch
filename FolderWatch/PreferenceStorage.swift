//
//  Storage.swift
//  TransL8
//
//  Created by Oliver Michalak on 16.12.19.
//  Copyright © 2019 Oliver Michalak. All rights reserved.
//

import Foundation


@propertyWrapper
struct PreferenceStorage<T: Codable> {

	private let key: String
	private let defaultValue: T
  private let store = UserDefaults.standard

	init(key: String, defaultValue: T) {
		self.key = key
		self.defaultValue = defaultValue
	}
	
	var wrappedValue: T {
		get {
			guard let data = store.object(forKey: key) as? Data else {
				return defaultValue
			}
			
			let value = try? JSONDecoder().decode(T.self, from: data)
			return value ?? defaultValue
		}
		set {
			let data = try? JSONEncoder().encode(newValue)
			
			store.set(data, forKey: key)
		}
	}
}
