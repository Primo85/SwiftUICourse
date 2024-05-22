import Foundation

struct Item: Hashable, Identifiable {
    let id = UUID().uuidString
    let name: String
    let imageName: String
}
