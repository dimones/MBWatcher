//
//  MBResult.swift
//  
//
//  Created by Богомолов Дмитрий Александрович on 09.11.2021.
//

import Foundation

//isIntel тут сугубо для тестов локальных, ввиду реального отсутствия в ресторе вообще нормальных маков
struct MBResult
{
	let name: String
	let cpu: String
	let cores: Int
	let gpuCores: Int
	let ram: Int
	let storage: Int
	let isIntel: Bool

	static func mainBook() -> Self {
		return .init(name: "MacBook Pro 16", cpu: "M1 Max", cores: 10, gpuCores: 32, ram: 32, storage: 1, isIntel: false)
	}

	static func topBook() -> Self {
		return .init(name: "MacBook Pro 16", cpu: "M1 Max", cores: 10, gpuCores: 32, ram: 64, storage: 1, isIntel: false)
	}

	static func testBook() -> Self {
		return .init(name: "MacBook Pro 14", cpu: "M1 Pro", cores: 10, gpuCores: 16, ram: 16, storage: 1, isIntel: false)
	}

	static func testReStore() -> Self {
		return .init(name: "MacBook Pro 16", cpu: "8 Core i9 2,3 ГГц", cores: 0, gpuCores: 0, ram: 16, storage: 1, isIntel: true)
	}

	func adopt(to: Store) -> String {
		switch to {
			case .mvideo:
				return "Ноутбук Apple \(self.name) \(self.cpu)/\(self.ram)/\(self.storage)Tb"
			case .reStore:
				if isIntel {
					return "Apple \(self.name)\" \(self.cpu), \(self.ram) ГБ, \(self.storage) ТБ"
				}
				else {
					return "Apple \(self.name)\" (\(self.cpu) \(self.cores)C, \(self.gpuCores)C GPU, 2021) \(self.ram) ГБ, \(self.storage) ТБ"
				}
		}
	}
}
