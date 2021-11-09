//
//  TGBot.swift
//  
//
//  Created by Богомолов Дмитрий Александрович on 09.11.2021.
//

import Foundation
import TelegramBotSDK

final class TGBot: Thread
{
	let bot: TelegramBot
	let usersRepo: UsersRepository

	init(bot: TelegramBot) throws {
		self.bot = bot
		self.usersRepo = try UsersRepository()
	}

	func informUsers(message: String) {
		self.usersRepo.getUsers().forEach { chat in
			self.bot.sendMessageAsync(chatId: chat, text: message)
		}
	}

	override func start() {
		self.run()
	}
}

private extension TGBot
{
	func run() {
		while let update = bot.nextUpdateSync() {
			if let message = update.message, let from = message.from {
				usersRepo.addUser(id: from.id)
				bot.sendMessageAsync(chatId: .chat(from.id),
									 text: "Ты подписался на обновления, пёс")
			}
			
			Thread.sleep(forTimeInterval: Configuration.botSleep)
		}
	}
}
