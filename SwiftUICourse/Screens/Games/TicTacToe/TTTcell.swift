
struct TTTcell: Identifiable {
    var id: String { "\(x)\(y)" }
    let x: Int
    let y: Int
    var state: TTTstate = .none
}

enum TTTstate: String {
    case X
    case O
    case none = "  "
    
    mutating func toggle() {
        switch self {
            case .X:
                self = .O
            case .O:
                self = .X
            case .none:
                break
        }
    }
}
