import Vapor
import Fluent

public final class Post: Model {
    public var id: Node?
    var text: String
    var userId: Node?
    
    init(id: Node? = nil, text: String, userId: Node? = nil) {
        self.id = id
        self.text = text
        self.userId = userId
    }

    public convenience init(text: String, user: User?) {
        self.init(text: text, userId: user?.id)
    }
}

// MARK: Node Conversions

extension Post {
    public convenience init(node: Node, in context: Vapor.Context) throws {
        self.init(
            id: try node.extract("id"),
            text: try node.extract("text"),
            userId: try node.extract("user_id")
        )
    }
    
    public func makeNode() throws -> Node {
        return try Node(node: [
            "id": id,
            "text": text,
            "user_id": userId
        ])
    }
    
    public func makeLeafNode() throws -> Node {
        return try Node(node: [
            "text": text,
            "user": try user().first()?.makeLeafNode()
        ])
    }
}

// MARK: Relations
extension Post {
    func user() throws -> Parent<User> {
        return try parent(userId, nil, User.self)
    }
}
