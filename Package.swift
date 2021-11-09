// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "MBWatcher",
	dependencies: [
		.package(name: "SwiftSoup", url: "https://github.com/scinfu/SwiftSoup.git", from: "1.7.4"),
		.package(name: "TelegramBotSDK", url: "https://github.com/zmeyc/telegram-bot-swift.git", from: "2.0.0"),
		.package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.0"),
	],
	targets: [
		.target(
			name: "MBWatcher",
			dependencies: [
				"SwiftSoup",
				"TelegramBotSDK",
				.product(name: "ArgumentParser", package: "swift-argument-parser"),
			]),
		.testTarget(
			name: "MBWatcherTests",
			dependencies: ["MBWatcher"]),
	]
)
