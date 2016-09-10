import Vapor
import HTTP

extension Application {
    public var middleware: [Middleware] {
        return [
            SampleMiddleware()
        ]
    }
}
