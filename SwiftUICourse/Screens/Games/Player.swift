import Foundation

struct Player: Identifiable {
    let id: String = UUID().uuidString
    let name: String
    var points = 0
}
