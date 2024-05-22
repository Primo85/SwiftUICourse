import Foundation

struct Card: Identifiable {
    let id = UUID().uuidString
    let file: String
    var state: CardState = .cover
    
    init(fileName: String) {
        self.file = fileName
    }
    
    var fileName: String {
        switch state {
            case .cover:
                return "mask"
            default:
                return file
        }
    }
    
    mutating func toggle() {
        switch state {
            case .dicover:
                state = .cover
            case .cover:
                state = .dicover
            case .resolved:
                break
        }
    }
    
    mutating func cover() {
        switch state {
            case .cover:
                break
            case .dicover:
                state = .cover
            case .resolved:
                break
        }
    }
    
}

enum CardState {
    case cover, dicover, resolved
}
