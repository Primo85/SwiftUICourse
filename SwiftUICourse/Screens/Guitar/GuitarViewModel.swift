import SwiftUI

final class GuitarViewModel: ObservableObject {
    
    @Published private(set) var freadBoard: [Fred] = []
    // OR:
//    private(set) var freadBoard: [Fred] = [] { willSet { objectWillChange.send() } }
    private var tune: [Sound] = Tunes.standardTune { didSet { setFredboard() } }
    private(set) var scale: Scale = Scale(key: .c, type: .pentatonic) { didSet { setFredboard() } }
    
    init() {
        setFredboard()
    }
    
    private func setFredboard() {
        var freadBoard: [Fred] = []
        for i in 0...24 {
            freadBoard.append(Fred(id: i,
                                   notes: tune.map { $0.add(i: i) }.map { scale.sounds.contains($0) ? Note(sound: $0) : Note(invisible: $0) }))
        }
        self.freadBoard = freadBoard
    }
    
    func changeScaleType(_ type: Scale.ScaleType) {
        scale = Scale(key: scale.key, type: type)
    }
    
    func changeKey(_ key: Sound) {
        scale = Scale(key: key, type: scale.type)
    }
    
    func select(sound: Sound) {
        print(sound.symbol)
    }
    
    var title: String {
        "\(scale.key.symbol) \(scale.type.rawValue)"
    }
}

struct Fred {
    let id: Int
    let notes: [Note]
    
    var dots: Int {
        switch id {
            case 3,5,7,9,15,17,19,21:
                return 1
            case 12:
                return 2
            default:
                return 0
        }
    }
}

struct Note: Identifiable {
    let sound: Sound
    let isVisible: Bool
    
    init(sound: Sound) {
        self.sound = sound
        self.isVisible = true
    }
    
    init(invisible sound: Sound) {
        self.sound = sound
        self.isVisible = false
    }
    
    var symbol: String { isVisible ? sound.symbol : " " }
    
    var id = UUID().uuidString
}

enum Sound: Int, CaseIterable {
    case c
    case cis
    case d
    case dis
    case e
    case f
    case fis
    case g
    case gis
    case a
    case ais
    case h

    func next() -> Self {
        Sound(rawValue: (self.rawValue + 1)%12)!
    }
    
    func add(i: Int) -> Self {
        Sound(rawValue: (self.rawValue + i)%12)!
    }
    
    var symbol: String {
        switch self {
            case .c:
                return "C"
            case .cis:
                return "C#"
            case .d:
                return "D"
            case .dis:
                return "D#"
            case .e:
                return "E"
            case .f:
                return "F"
            case .fis:
                return "F#"
            case .g:
                return "G"
            case .gis:
                return "G#"
            case .a:
                return "A"
            case .ais:
                return "A#"
            case .h:
                return "H"
        }
    }
}

struct Scale {
    let key: Sound
    let type: ScaleType
    
    enum ScaleType: String, CaseIterable {
        case pentatonic
        case major
        case blues
        case blues7
        case minor
        case minorH
        case minorM
        case spahish
        
        var intervals: [Int] {
            switch self {
                case .pentatonic:
                    return [2, 2, 3, 2]//3
                case .major:
                    return [2, 2, 1, 2, 2, 2]//1
                case .blues:
                    return [2, 1, 1, 3, 2]//3
                case .blues7:
                    return [2, 1, 1, 3, 2, 2]//1
                case .minor:
                    return [2, 1, 2, 2, 1, 2]//2
                case .minorH:
                    return [2, 1, 2, 2, 1, 3]//1
                case .minorM:
                    return [2, 1, 2, 2, 2, 2]//1
                case .spahish:
                    return [1, 3, 1, 2, 1, 2]//2
            }
        }
    }
    
    var sounds: [Sound] {
        var sound: Sound = key
        var sounds: [Sound] = [sound]
        for i in type.intervals {
            sound = sound.add(i: i)
            sounds.append(sound)
        }
        return sounds
    }
}

enum Tunes {
    static let standardTune: [Sound] = [.e, .h, .g, .d, .a, .e]
    static let bass5Tune: [Sound] = [.g, .d, .a, .e, .h]
    static let circleOf5th: [Sound] = [.c, .g, .d, .a, .e, .h, .fis, .cis, .gis, .dis, .ais, .f]
}
