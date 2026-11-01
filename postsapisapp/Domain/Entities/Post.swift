import Foundation

struct Post: Identifiable, Equatable, Sendable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}
