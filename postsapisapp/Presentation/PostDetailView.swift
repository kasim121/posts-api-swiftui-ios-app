import SwiftUI

struct PostDetailView: View {
    let post: Post

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                PostDetailHeader(title: post.title, userId: post.userId)
                PostDetailBody(text: post.body)
            }
            .padding()
        }
        .navigationTitle("Post Details")
    }
}

private struct PostDetailHeader: View {
    let title: String
    let userId: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title.capitalized)
                .font(.largeTitle)
                .fontWeight(.bold)

            Label("User ID: \(userId)", systemImage: "person")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
}

private struct PostDetailBody: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.body)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    NavigationStack {
        PostDetailView(
            post: Post(
                id: 1,
                userId: 1,
                title: "Example post",
                body: "This is the complete post body shown on the details screen."
            )
        )
    }
}
