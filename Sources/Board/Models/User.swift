import Vapor
import Mustache
import Fluent

public final class User: Model {
    public var id: Node?
    var name: String
    
    init(id: Node? = nil, name: String) {
        self.id = id
        self.name = name
    }
}

// MARK: Node Conversions

extension User {
    public convenience init(node: Node, in context: Vapor.Context) throws {
        self.init(
            id: try node.extract("id"),
            name: try node.extract("name")
        )
    }

    public func makeNode() throws -> Node {
        return try Node(node: [
            "id": id,
            "name": name
        ])
    }
}

// MARK: Relations

extension User {
    func posts() -> Children<Post> {
        return children(Post.self)
    }
    
    func postCount() throws -> Int {
        return try children(Post.self).all().count // TODO: Make more efficient? Raw query?
    }
}

/**
	Here, we must make the Post object
	usable from the Mustache documents,
	so we have to tell Mustache how this
	data behaves.
*/
extension User: MustacheBoxable {
	public var mustacheBox: MustacheBox {
		return MustacheBox(
			value: self,
			boolValue: nil,
			keyedSubscript: keyedSubscriptFunction,
			filter: nil,
			render: nil,
			willRender: nil,
			didRender: nil
		)
	}
	
	func keyedSubscriptFunction(key: String) -> MustacheBox {
		switch key {
		case "id":
			return (id?.int?.mustacheBox)!
		case "name":
			return name.mustacheBox
		case "post-count":
			return try! postCount().mustacheBox
		default:
			return Box()
		}
	}
}
