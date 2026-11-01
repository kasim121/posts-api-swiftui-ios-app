import Foundation

enum APIConstants {
    static let baseURL: URL = {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com") else {
            preconditionFailure("The posts API base URL is invalid.")
        }
        return url
    }()

    static let postsPath = "/posts"
}
