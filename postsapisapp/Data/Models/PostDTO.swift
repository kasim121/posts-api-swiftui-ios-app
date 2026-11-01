import Foundation

struct PostDTO: Decodable, Sendable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
