import SwiftUI
import Combine

final class MathTestViewModel: ObservableObject {
    
    // MARK: User interface
    @Published var table: [MathCell] = {
        var table: [MathCell] = []
        for _ in 0..<100 { table.append(MathCell()) }
        return table
    }()
    @Published var text: String = ""
    @Published var isCorrect: Bool?
    @Published var isSummaryPresented: Bool = false
    
    // MARK: User actions
    func tapOn(action: NumberPadAction) {
        switch action {
        case .number(let n):
            joinToA(n)
        case .delete:
            reduceA()
        case .enter:
            checkEquation()
        }
    }
    
    func tapOn(id: String) {
        guard let i = table.firstIndex(where: { $0.id == id} ) else { return }
        table[i].value.toggle()
    }
    
    func reset() {
        setIndex.value = 0
        result.value = nil
    }
    
    // MARK: Model
    private let player: Player
    private var x = CurrentValueSubject<Int, Never>(Int.random(in: 0...9))
    private var eq = CurrentValueSubject<Equation, Never>(.plus)
    private var y = CurrentValueSubject<Int, Never>(Int.random(in: 0...9))
    private var a = CurrentValueSubject<Int?, Never>(nil)
    
    private let setIndex = CurrentValueSubject<Int, Never>(0)
    let result = CurrentValueSubject<GameResult?, Never>(nil)
    let failureCounter = CurrentValueSubject<Int, Never>(0)
    let successCounter = CurrentValueSubject<Int, Never>(0)
    
    private var subjects = Set<AnyCancellable>()
    
    init(player: Player) {
        self.player = player
        bind()
    }
    
    private func bind() {
        a
            .map {
                if let a = $0 { return "\(a)" }
                else { return "?" }
            }
            .combineLatest(x, eq, y)
            .map { "\($1) \($2.rawValue) \($3) = \($0)" }
            .sink { [weak self] s in
                self?.text = s
            }
            .store(in: &subjects)
        
        failureCounter
            .combineLatest(successCounter, result)
            .filter { !($0 == 0 && $1 == 0) && $2 == nil }
            .delay(for: 1, scheduler: RunLoop.main)
            .sink { [weak self] _ in
                self?.setIndex.value++
            }
            .store(in: &subjects)
        
        setIndex
            .sink { [weak self] in
                if $0 == 10 {
                    self?.result.send(.victory(player: self?.player.name ?? ""))
                }
            }
            .store(in: &subjects)
        
        result
            .map { $0 != nil }
            .filter { $0 }
            .delay(for: 0.5, scheduler: RunLoop.main)
            .assign(to: &$isSummaryPresented)
    }
    
    private func joinToA(_ n: Int) {
        guard let oldA = a.value else {
            a.value = n
            return
        }
        a.value = oldA * 10 + n
    }
    
    private func reduceA() {
        guard let oldA = a.value else {
            return
        }
        if oldA < 10 {
            a.value = nil
        } else {
            a.value = oldA / 10
        }
    }
    
    private func checkEquation() {
        let result: Int = {
            switch eq.value {
            case .plus:
                return x.value + y.value
            case .minus:
                return x.value - y.value
            case .multi:
                return x.value * y.value
            case .div:
                return x.value / y.value
            }
        }()
        if result == a.value {
            isCorrect = true
            successCounter.value++
        } else {
            isCorrect = false
            failureCounter.value++
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.resetEquation()
        }
    }
    
    private func resetEquation() {
        eq.value = [.minus, .div].randomElement()! //Equation.allCases.randomElement()!
        switch eq.value {
        case .plus:
            x.value = Int.random(in: 0...9)
            y.value = Int.random(in: 0...9)
        case .minus:
            var a = 0
            var b = 0
            repeat {
                a = Int.random(in: 0...9)
                b = Int.random(in: 0...9)
            } while a - b < 0
            x.value = a
            y.value = b
        case .multi:
            var a = 0
            var b = 0
            repeat {
                a = Int.random(in: 0...9)
                b = Int.random(in: 0...9)
            } while a * b > 25
            x.value = a
            y.value = b
        case .div:
            var a = 0
            var b = 0
            repeat {
                a = Int.random(in: 0...9)
                b = Int.random(in: 1...9)
            } while a % b != 0
            x.value = a
            y.value = b
        }
        
        a.value = nil
        isCorrect = nil
        for i in 0..<table.count {
            table[i].value = false
        }
    }
    
    enum Equation: String, CaseIterable {
        case plus = "+"
        case minus = "-"
        case multi = "x"
        case div = ":"
    }
}

struct MathCell: Identifiable {
    let id: String = UUID().uuidString
    var value: Bool = false
}
