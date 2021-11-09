//
//  UsersRepository.swift
//  
//
//  Created by Богомолов Дмитрий Александрович on 09.11.2021.
//

import Foundation
import TelegramBotSDK

final class UsersRepository
{
	private let fm = FileManager.default
	private let filePath = FileManager.default.currentDirectoryPath + "/users"
	private var users: [Int64]

	init() throws {
		if fm.fileExists(atPath: filePath) {
			let usersString = try String(contentsOfFile: self.filePath)
			self.users = usersString
				.split(separator: "\n")
				.map(String.init)
				.compactMap { idString in
					return Int64(idString)
				}

			print("Запустились с \(self.users.count) пользователями")
		}
		else {
			self.users = []
		}
	}

	func addUser(id: Int64) {
		if !self.users.contains(id) {
			print("Новый юзер к нам пришел")
			self.users.append(id)
			self.save()
		}
	}

	func getUsers() -> [ChatId] {
		return self.users.map { ChatId.chat($0) }
	}
}

private extension UsersRepository
{
	func save() {
		do {
			let stringToSave = self.users.map(String.init).joined(separator: "\n")

			try stringToSave.write(toFile: self.filePath, atomically: true, encoding: .utf8)
		} catch {
			print("Произошла ошибка при записи в файл: \(error.localizedDescription)")
		}
	}
}
