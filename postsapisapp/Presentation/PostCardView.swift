import SwiftUI

struct PostCardView: View {
    let post: Post

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(post.title.capitalized)
                .font(.headline)

            Text(post.body)
                .font(.body)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    PostCardView(
        post: Post(
            id: 1,
            userId: 1,
            title: "Example post",
            body: "This is an example post."
        )
    )
}
