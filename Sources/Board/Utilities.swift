import Leaf

extension Argument {
    var value: Node? {
        switch self {
        case let .constant(value: value):
            return .string(value)
        case let .variable(path: _, value: value):
            return value
        }
    }
}
