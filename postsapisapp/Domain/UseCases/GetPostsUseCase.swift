import Foundation

struct GetPostsUseCase: Sendable {
    private let repository: PostRepository

    init(repository: PostRepository) {
        self.repository = repository
    }

    func execute() async throws -> [Post] {
        try await repository.fetchPosts()
    }
}
