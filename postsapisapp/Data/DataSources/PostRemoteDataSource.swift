import Foundation

protocol PostRemoteDataSource: Sendable {
    func fetchPosts() async throws -> [PostDTO]
}

struct DefaultPostRemoteDataSource: PostRemoteDataSource {
    private let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func fetchPosts() async throws -> [PostDTO] {
        try await apiClient.get(APIConstants.postsPath)
    }
}
