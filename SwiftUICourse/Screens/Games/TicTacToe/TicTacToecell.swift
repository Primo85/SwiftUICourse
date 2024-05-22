
struct TicTacToecell: Identifiable {
    var id: String { "\(x)\(y)" }
    let x: Int
    let y: Int
    var state: TicTacToestate = .none
}

enum TicTacToestate: String {
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
