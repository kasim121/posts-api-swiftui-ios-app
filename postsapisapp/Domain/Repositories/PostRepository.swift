import Foundation

protocol PostRepository: Sendable {
    func fetchPosts() async throws -> [Post]
}
