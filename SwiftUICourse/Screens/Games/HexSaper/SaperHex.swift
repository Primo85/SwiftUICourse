import Foundation

struct SaperHex: Identifiable {
    let id: String = UUID().uuidString
    
    var hasBomb: Bool = false
    var state: SaperCellState = .unmarked
    
    var resolved: Bool {
        switch (hasBomb, state) {
            case (true, .marked):
                return true
            case (false, .discover):
                return true
            default:
                return false
        }
    }
}

enum SaperCellState {
    case marked
    case unmarked
    case discover(Int)
}
