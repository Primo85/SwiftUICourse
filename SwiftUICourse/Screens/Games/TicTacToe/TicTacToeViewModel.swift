import SwiftUI
import Combine

final class TicTacToeViewModel: ObservableObject {
    
    @Published private(set) var cells: [TicTacToecell]
    @Published private(set) var players: [Player]
    @Published var isSummaryPresented: Bool = false
    
    @Published private(set) var line: TicTacToeLineType?
    @Published private(set) var winnerName: String?
    
    private var counter = CurrentValueSubject<Int, Never>(0)
    private var winnerIndex = CurrentValueSubject<Int?, Never>(nil)
    private(set) var animationComleted = PassthroughSubject<Bool, Never>()
    private var currentPlayerIndex = 0
    private var currentState: TicTacToestate = .X
    
    private var subjects = Set<AnyCancellable>()
    
    init(players: [Player]) {
        self.players = players
        self.cells = {
            var cells: [TicTacToecell] = []
            for y in 0..<3 {
                for x in 0..<3 {
                    cells.append(TicTacToecell(x: x, y: y))
                }
            }
            return cells
        }()
        bind()
    }
    
    private func bind() {
        winnerIndex
            .compactMap { $0 }
            .sink { [weak self] in self?.players[$0].points++ }
            .store(in: &subjects)
        
        winnerIndex
            .map { [weak self] in self?.players[safe: $0]?.name }
            .assign(to: &$winnerName)
        
        counter
            .map { $0 == 9 }
            .filter { $0 }
            .assign(to: &$isSummaryPresented)
        
        animationComleted
            .filter { $0 }
            .assign(to: &$isSummaryPresented) // TODO: try to combine counter and animationComleted somehow
    }
    
    func click(on id: String) {
        guard winnerIndex.value == nil,
              let i = cells.firstIndex(where: { $0.id == id} ),
              cells[i].state == .none else { return }
        cells[i].state = currentState
        currentState.toggle()
        counter.value++
        checkSolution(for: .X)
        checkSolution(for: .O)
        switchPlayer()
    }
    
    func reset() {
        counter.value = 0
        currentPlayerIndex = 0
        currentState = .X
        for i in 0..<cells.count {
            cells[i].state = .none
        }
        line = nil
        winnerIndex.value = nil
    }
    
    var currentID: String {
        players[currentPlayerIndex].id
    }
    
    // MARK: private
    
    private func checkSolution(for state: TicTacToestate) {
        let cells = cells.filter { $0.state == state }
        let index = state == .X ? 0 : 1
        for x in 0..<3 {
            if cells.contains(where: { $0.x == x && $0.y == 0 }),
               cells.contains(where: { $0.x == x && $0.y == 1 }),
               cells.contains(where: { $0.x == x && $0.y == 2 }) {
                line = .x(CGFloat(x))
                winnerIndex.send(index)
            }
        }
        for y in 0..<3 {
            if cells.contains(where: { $0.y == y && $0.x == 0 }),
               cells.contains(where: { $0.y == y && $0.x == 1 }),
               cells.contains(where: { $0.y == y && $0.x == 2 }) {
                line = .y(CGFloat(y))
                winnerIndex.send(index)
            }
        }
        if cells.contains(where: { $0.y == 0 && $0.x == 0 }),
           cells.contains(where: { $0.y == 1 && $0.x == 1 }),
           cells.contains(where: { $0.y == 2 && $0.x == 2 }) {
            line = .d1
            winnerIndex.send(index)
        }
        if cells.contains(where: { $0.y == 0 && $0.x == 2 }),
           cells.contains(where: { $0.y == 1 && $0.x == 1 }),
           cells.contains(where: { $0.y == 2 && $0.x == 0 }) {
            line = .d2
            winnerIndex.send(index)
        }
    }
    
    private func switchPlayer() {
        guard counter.value < 9,
              winnerIndex.value == nil else { return }
        currentPlayerIndex = (currentPlayerIndex + 1) % players.count
    }
}

enum TicTacToeLineType: Equatable {
    case x(CGFloat)
    case y(CGFloat)
    case d1, d2
}
