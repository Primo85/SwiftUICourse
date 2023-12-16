import SwiftUI
import Combine

final class TicTacToeViewModel: ObservableObject {
    
    @Published private(set) var cells: [TTTcell]
    @Published private(set) var players: [Player]
    @Published var isSummaryPresented: Bool = false
    
    @Published private(set) var line: TicTacToeLineType?
    @Published private(set) var winnerName: String?
    
    private var counter = CurrentValueSubject<Int, Never>(0)
    private var winnerIndex = CurrentValueSubject<Int?, Never>(nil)
    private(set) var animationComleted = PassthroughSubject<Bool, Never>()
    private var currentPlayerIndex = 0
    private var currentState: TTTstate = .X
    
    private var subjects = Set<AnyCancellable>()
    
    init(players: [Player]) {
        self.players = players
        self.cells = {
            var cells: [TTTcell] = []
            for y in 0..<3 {
                for x in 0..<3 {
                    cells.append(TTTcell(x: x, y: y))
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
            .assign(to: &$isSummaryPresented)
    }
    
    func click(on id: String) {
        guard winnerIndex.value == nil,
              let i = cells.firstIndex(where: { $0.id == id} ),
              cells[i].state == .none else { return }
        cells[i].state = currentState
        currentState.toggle()
        counter.value++
        checkSolution()
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
    
    private func checkSolution() {
        let Xcells = cells.filter { $0.state == .X }
        let Ocells = cells.filter { $0.state == .O }
        for x in 0..<3 {
            if Xcells.contains(where: { $0.x == x && $0.y == 0 }),
               Xcells.contains(where: { $0.x == x && $0.y == 1 }),
               Xcells.contains(where: { $0.x == x && $0.y == 2 }) {
                print("check if")
                line = .x(CGFloat(x))
                winnerIndex.send(0)
            }
            if Ocells.contains(where: { $0.x == x && $0.y == 0 }),
               Ocells.contains(where: { $0.x == x && $0.y == 1 }),
               Ocells.contains(where: { $0.x == x && $0.y == 2 }) {
                print("check if")
                line = .x(CGFloat(x))
                winnerIndex.send(1)
            }
        }
        for y in 0..<3 {
            if Xcells.contains(where: { $0.y == y && $0.x == 0 }),
               Xcells.contains(where: { $0.y == y && $0.x == 1 }),
               Xcells.contains(where: { $0.y == y && $0.x == 2 }) {
                print("check if")
                line = .y(CGFloat(y))
                winnerIndex.send(0)
            }
            if Ocells.contains(where: { $0.y == y && $0.x == 0 }),
               Ocells.contains(where: { $0.y == y && $0.x == 1 }),
               Ocells.contains(where: { $0.y == y && $0.x == 2 }) {
                print("check if")
                line = .y(CGFloat(y))
                winnerIndex.send(1)
            }
        }
        if Xcells.contains(where: { $0.y == 0 && $0.x == 0 }),
           Xcells.contains(where: { $0.y == 1 && $0.x == 1 }),
           Xcells.contains(where: { $0.y == 2 && $0.x == 2 }) {
            print("check if")
            line = .d1
            winnerIndex.send(0)
        }
        if Xcells.contains(where: { $0.y == 0 && $0.x == 2 }),
           Xcells.contains(where: { $0.y == 1 && $0.x == 1 }),
           Xcells.contains(where: { $0.y == 2 && $0.x == 0 }) {
            print("check if")
            line = .d2
            winnerIndex.send(0)
        }
        if Ocells.contains(where: { $0.y == 0 && $0.x == 0 }),
           Ocells.contains(where: { $0.y == 1 && $0.x == 1 }),
           Ocells.contains(where: { $0.y == 2 && $0.x == 2 }) {
            print("check if")
            line = .d1
            winnerIndex.send(1)
        }
        if Ocells.contains(where: { $0.y == 0 && $0.x == 2 }),
           Ocells.contains(where: { $0.y == 1 && $0.x == 1 }),
           Ocells.contains(where: { $0.y == 2 && $0.x == 0 }) {
            print("check if")
            line = .d2
            winnerIndex.send(1)
        }
    }
    
    private func switchPlayer() {
        guard counter.value < 9,
              winnerIndex.value == nil else { return }
        currentPlayerIndex = (currentPlayerIndex + 1) % players.count
    }
    
    deinit {
        print("TicTacToeViewModel deinit")
    }
}
