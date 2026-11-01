import Foundation
import Observation

enum PostViewState: Equatable {
    case initial
    case loading
    case loaded([Post])
    case failed(String)
}

@MainActor
@Observable
final class PostViewModel {
    private let getPostsUseCase: GetPostsUseCase
    private(set) var state: PostViewState = .initial

    init(getPostsUseCase: GetPostsUseCase? = nil) {
        self.getPostsUseCase = getPostsUseCase ?? DependencyContainer.makeGetPostsUseCase()
    }

    func fetchPosts() async {
        state = .loading

        do {
            let posts = try await getPostsUseCase.execute()
            state = .loaded(posts)
        } catch {
            state = .failed(error.localizedDescription)
        }
    }
}

enum DependencyContainer {
    static func makeGetPostsUseCase() -> GetPostsUseCase {
        let apiClient = APIClient()
        let dataSource = DefaultPostRemoteDataSource(apiClient: apiClient)
        let repository = DefaultPostRepository(dataSource: dataSource)
        return GetPostsUseCase(repository: repository)
    }
}
