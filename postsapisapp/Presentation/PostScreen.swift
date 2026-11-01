import SwiftUI

struct PostScreen: View {
    @State private var viewModel: PostViewModel

    init(viewModel: PostViewModel? = nil) {
        _viewModel = State(initialValue: viewModel ?? PostViewModel())
    }

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Posts")
        }
        .task {
            guard case .initial = viewModel.state else { return }
            await viewModel.fetchPosts()
        }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .initial, .loading:
            ProgressView("Loading posts…")
        case .loaded(let posts):
            List(posts) { post in
                NavigationLink {
                    PostDetailView(post: post)
                } label: {
                    PostCardView(post: post)
                }
            }
            .listStyle(.plain)
        case .failed(let message):
            PostErrorView(message: message) {
                Task {
                    await viewModel.fetchPosts()
                }
            }
        }
    }
}

private struct PostErrorView: View {
    let message: String
    let retry: () -> Void

    var body: some View {
        ContentUnavailableView {
            Label("Unable to Load Posts", systemImage: "exclamationmark.triangle")
        } description: {
            Text(message)
        } actions: {
            Button("Try Again", action: retry)
                .buttonStyle(.borderedProminent)
        }
    }
}

private struct PreviewPostRepository: PostRepository {
    func fetchPosts() async throws -> [Post] {
        [
            Post(
                id: 1,
                userId: 1,
                title: "Preview post",
                body: "Sample content shown without a network connection."
            ),
            Post(
                id: 2,
                userId: 1,
                title: "Another preview post",
                body: "The live app continues to load posts from the API."
            )
        ]
    }
}

#Preview {
    let repository = PreviewPostRepository()
    let useCase = GetPostsUseCase(repository: repository)
    let viewModel = PostViewModel(getPostsUseCase: useCase)

    PostScreen(viewModel: viewModel)
}
