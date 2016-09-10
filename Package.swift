import PackageDescription

let package = Package(
	name: "BoardApp",
	targets: [
		Target(name: "Board"),
		Target(name: "App", dependencies: ["Board"])
	],
    dependencies: [
        .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 0, minor: 18),
        .Package(url: "https://github.com/vapor/mysql-provider.git", majorVersion: 0, minor: 6)
    ],
    exclude: [
        "Config",
        "Database",
        "Localization",
        "Public",
        "Resources",
        "Tests",
    ]
)

