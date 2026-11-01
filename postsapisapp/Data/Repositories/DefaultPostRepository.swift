import Foundation

struct DefaultPostRepository: PostRepository {
    private let dataSource: PostRemoteDataSource

    init(dataSource: PostRemoteDataSource) {
        self.dataSource = dataSource
    }

    func fetchPosts() async throws -> [Post] {
        let postDTOs = try await dataSource.fetchPosts()

        return postDTOs.map { postDTO in
            Post(
                id: postDTO.id,
                userId: postDTO.userId,
                title: postDTO.title,
                body: postDTO.body
            )
        }
    }
}
