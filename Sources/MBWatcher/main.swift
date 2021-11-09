import Foundation
import TelegramBotSDK
import ArgumentParser

struct Main: ParsableCommand
{
	@Option(help: "Put you bot id")
	var botId: String?

	mutating func run() throws {
		print("Bot ID: \(botId)")
		guard let botId = botId else {
			fatalError("Не указан bot id от Telegram")
		}

		let tgBot = try TGBot(bot: TelegramBot(token: botId))

		//Стартуем тред с фетчингом
		DispatchQueue.global().async {
			Fetcher(bot: tgBot).start()
		}

		//Стартуем тред с ботом и его обслугой
		DispatchQueue.global().async {
			tgBot.start()
		}

		//Лочим мейнтред, радуемся исполнению
		while true { print("Working"); Thread.sleep(forTimeInterval: 60 * 15)}

	}
}

Main.main()
