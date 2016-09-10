import Fluent

extension Post {
	public static func prepare(_ database: Database) throws {
		try database.create(entity) { users in
			users.id()
			users.string("text")
			users.parent(User.self, optional: false)
		}
	}
	
	public static func revert(_ database: Database) throws {
		try database.delete(entity)
	}
}
