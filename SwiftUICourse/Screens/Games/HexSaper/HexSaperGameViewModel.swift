import SwiftUI
import Combine

class HexSaperGameViewModel: ObservableObject {
    
    @Published var table: [[SaperHex]] = [
        [SaperHex(),SaperHex(),SaperHex(),SaperHex()],
        [SaperHex(),SaperHex(),SaperHex(),SaperHex()],
        [SaperHex(),SaperHex(),SaperHex(),SaperHex()],
        [SaperHex(),SaperHex(),SaperHex(),SaperHex()],
        [SaperHex(),SaperHex(),SaperHex(),SaperHex()]
    ]
    @Published var bombCount: Int = 0
    @Published var fails: Int = 0
    @Published var successes: Int = 0
    @Published var isSummaryPresented: Bool = false
    
    
    let result = CurrentValueSubject<GameResult?, Never>(nil)
    let player: Player
    
    private var subjects = Set<AnyCancellable>()
    
    init(player: Player) {
        self.player = player
        setTable()
        bind()
    }
    
    private func bind() {
        result
            .map { $0 != nil }
            .filter { $0 }
            .assign(to: &$isSummaryPresented)
        
        result
            .compactMap { $0 }
            .filter { if case GameResult.victory = $0 { return true } else { return false} }
            .sink { [weak self] _ in self?.successes++ }
            .store(in: &subjects)
        
        result
            .compactMap { $0 }
            .filter { if case GameResult.defeat = $0 { return true } else { return false} }
            .sink { [weak self] _ in self?.fails++ }
            .store(in: &subjects)
    }
    
    
    func click(_ id: String) {
        guard result.value == nil,
              let i = table.firstIndex(where: { $0.contains { $0.id == id }}),
              let j = table[i].firstIndex(where: { $0.id == id }) else { return }
        discover(i: i, j: j)
    }
    
    func mark(_ id: String) {
        guard result.value == nil,
              let i = table.firstIndex(where: { $0.contains { $0.id == id }}),
              let j = table[i].firstIndex(where: { $0.id == id }) else { return }
        switch table[i][j].state {
            case .marked:
                table[i][j].state = .unmarked
            case .unmarked:
                table[i][j].state = .marked
            case .discover:
                break
        }
        checkEndOfGame()
    }
    
    func reset() {
        setTable()
        result.send(nil)
    }
    
    private func discover(i: Int, j: Int) {
        switch table[i][j].state {
            case .marked:
                break
            case .unmarked:
                table[i][j].state = .discover(getNumber(i: i, j: j))
                if table[i][j].hasBomb {
                    result.send(.defeat)
                } else {
                    checkEndOfGame()
                }
            case .discover:
                break
        }
    }
    
    private func getNumber(i: Int, j: Int) -> Int {
        var counter = 0
        let jr = i%2 == 0 ? j-1 : j+1
        if table[safe: i+1]?[safe: jr]?.hasBomb ?? false { counter++ }
        if table[safe: i+1]?[safe: j]?.hasBomb ?? false { counter++ }
        if table[safe: i]?[safe: j+1]?.hasBomb ?? false { counter++ }
        if table[safe: i]?[safe: j-1]?.hasBomb ?? false { counter++ }
        if table[safe: i-1]?[safe: jr]?.hasBomb ?? false { counter++ }
        if table[safe: i-1]?[safe: j]?.hasBomb ?? false { counter++ }
        return counter
    }
    
    private func checkEndOfGame() {
        if !table.contains(where: { $0.contains { !$0.resolved } }) {
            result.send(.victory(player.name))
        }
    }
    
    private func setTable() {
        for i in 0..<table.count {
            for j in 0..<table[i].count {
                table[i][j] = SaperHex()
            }
        }
        
        let b = [3,4].randomElement()!
        var c = 0
        while c < b {
            let i = Int.random(in: 0..<table.count)
            let j = Int.random(in: 0..<table[i].count)
            if !table[i][j].hasBomb {
                table[i][j].hasBomb = true
                c++
            }
        }
        
        for i in 0..<table.count {
            for j in 0..<table[i].count {
                if getNumber(i: i, j: j) == 0, !table[i][j].hasBomb {
                    print("click")
                    discover(i: i, j: j)
                }
            }
        }
        
        var counter = 0
        table.forEach { $0.forEach { $0.hasBomb ? counter++ : nil } }
        bombCount = counter
    }
}
