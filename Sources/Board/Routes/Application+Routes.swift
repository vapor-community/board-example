import Vapor
import HTTP
import Routing

extension Application {
    public func routes(_ drop: Droplet) {
        // MARK: Board
        let board = BoardController(droplet: drop)
        drop.resource("/", board)
		
		// MARK: Databse
        /**
            Here is an example of a route without a controller.

            This provides an endpoint to check that your datbase
            is working and what version it's running.
        */
        drop.get("db-version") { request in
            guard let database = drop.database else {
                return "Your database is not set up. Please see the README.md."
            }
            
            guard let version = try database.driver.raw("SELECT @@version AS version")[0].object?["version"].string else {
                return try JSON(["error": "Could not get database version."])
            }
            
            return try JSON([
                "version": version
            ])
        }
    }
}
