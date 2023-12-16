import SwiftUI

// TODO: MemoGameViewModel and MemoGameViewModelImpl

final class MemoGameViewModel: ObservableObject {
    
    let size: Int
    private let pairs: Int
    
    @Published private(set) var cards: [Card] = []
    @Published private(set) var players: [Player]
    @Published var isSummaryPresented: Bool = false
    
    private(set) var failCounter: Int = 0
    @UserDefaultsBackend<Int>() private(set) var bestResult
    private var userInteractionEnabled = true
    private var currentPlayerIndex = 0
    private var firstPicture: String?
    
    init(size: Int, players: [Player]) {
        let size = min(max(size, 2), 8)
        self.size = size
        let pairs = size*size/2
        self.pairs = pairs
        self._bestResult = UserDefaultsBackend<Int>(key: .memo(size))
        self.players = players
        getCards()
        print("init MemoGameViewModel")
    }
    
    var currentID: String {
        players[currentPlayerIndex].id
    }
    
    var winnerName: String? { // TODO: some refactor ?
        if players.count == 1 {
            return players.first?.name
        } else if players.count > 1 {
            let sortedPlayers = players.sorted(by: { $0.points > $1.points })
            if sortedPlayers[0].points > sortedPlayers[1].points {
                return sortedPlayers.first?.name
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    func click(on id: String) {
        guard userInteractionEnabled,
              let i = cards.firstIndex(where: { $0.id == id} ),
              cards[i].state == .cover else { return }
        cards[i].toggle()
        if let picture = firstPicture {
            checkResult(i: i, picture: picture)
        } else {
            firstPicture = cards[i].file
        }
    }
    
    func reset() {
        failCounter = 0
        currentPlayerIndex = 0
        firstPicture = nil
        getCards()
        for i in 0..<players.count {
            players[i].points = 0
        }
    }
    
    private func checkResult(i: Int, picture: String) {
        if picture == cards[i].file {
            for j in 0..<cards.count {
                if cards[j].file == picture {
                    cards[j].state = .resolved
                }
            }
            players[currentPlayerIndex].points++
            checkEndOfGame()
        } else {
            failCounter++
            coverAll()
        }
        firstPicture = nil
    }
    
    private func checkEndOfGame() {
        if pairs == getPoints() {
            isSummaryPresented = true
            bestResult = failCounter < bestResult ?? 10000 ? failCounter : bestResult // TODO: some refactor ?
        }
    }
    
    private func getCards() {
        self.cards = MockData
            .getAnimalCardNames(pairs: pairs)
            .map { Card(fileName: $0) }
    }
    
    private func switchPlayer() {
        currentPlayerIndex = (currentPlayerIndex + 1) % players.count
    }
    
    private func getPoints() -> Int {
        var sum = 0
        players.forEach { sum += $0.points }
        return sum
    }
    
    private func coverAll() {
        userInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let self = self  else { return }
            for i in 0..<self.cards.count {
                self.cards[i].cover()
            }
            switchPlayer()
            userInteractionEnabled = true
        }
    }
    
    deinit {
        print("deinit MemoGameViewModel")
    }
}
