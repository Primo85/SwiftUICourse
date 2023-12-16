import Foundation

struct ContolFlow {
    static let tab: [Int] = [1,2,3,4]

    static func forLoop() {
        for x in tab { print(x) }
        for x in tab[1...] { print(x) }
        for x in tab[...2] { print(x) }
        for x in tab[..<2] { print(x) }
        let range = 0...3
        for x in tab[range] { print(x) }
        for x in stride(from: 0, to: 12, by: 2) { print(x) } // 0...10
        for x in stride(from: 0, through: 12, by: 2) { print(x) } // 0...12
    }

    static func whileLoop() {
        var c = 22
        while c<10 {
            print(c)
            c++
        }
        
        var i = 22
        repeat {
            print(i)
            i++
        } while i<10
    }
    
    static func breakingLoop() {
        let tab = [1,2,3,4,5,6,7,8,9]
        for i in tab {
            print("item \(i)")
            if i < 5 {
                print("less then 5")
            } else {
//                continue // and of iteration, continue loop
//                break // and of whole loop
//                return // and of whole function
            }
            print("other stuff in loop")
        }
        print("end of funcion")
    }
    
    enum Direction {
        case north, south, west, east
    }
    
    enum Code {
        case barCode(Int)
        case qrCode(String)
    }
    
    static func conditionsExamples() {
        let direction: Direction = .north
        
        switch direction {
            case .north:
                print("north from switch ...")
            default:
                break
        }
        if direction == .north {
            print("north from if ...")
        }
        if case .north = direction {
            print("north from if case ...")
        }
        
        let qrCode: Code = .qrCode("some_code")
        
        if case .qrCode = qrCode {
            print("qrCode from if case ...")
        }
        if case let .qrCode(content) = qrCode, content == "some_code" {
            print("\(content) from if case let ... ")
        }
        
        let codes: [Code] = [Code.barCode(1),
                             Code.barCode(2),
                             Code.barCode(3),
                             Code.barCode(4),
                             Code.barCode(5),
                             Code.qrCode("a"),
                             Code.qrCode("b"),
                             Code.qrCode("c"),
                             Code.qrCode("d"),]
        for case let .qrCode(code) in codes { print("for case let \(code)") }
        for case let .barCode(code) in codes where code < 3 { print("for case let ... where \(code)") }
    }
}
