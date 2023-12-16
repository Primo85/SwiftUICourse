import SwiftUI

struct GamesView: View {
    
    @State private var isMemoPresented: Bool = false
    @State private var memoSizePresented = false
    @State private var isTicTacToePresented: Bool = false
    @State private var AIContentPresented: Bool = false
    @State private var memoSize = 4
    @State private var alertPresented: Bool = false
    @State private var players: [Player] = [Player(name: "Przemo"), Player(name: "Karolina")]
    @State private var playerToAdd: String = ""
    
    func addPlayer() {
        players.append(Player(name: playerToAdd))
        playerToAdd = ""
    }
    
    func deletePlayer(_ player: Player) {
        guard let i = players.firstIndex(where: { $0.id == player.id }) else { return }
        players.remove(at: i)
    }
    
    func resultFor(size: Int) -> String {
        @UserDefaultsBackend<Int>(key: .memo(size)) var result
        return String(result) ?? "-"
    }
    
    var body: some View {
        HStack {
            Spacer()
            VStack(spacing: 32) {
                Text("Players:")
                    .font(.largeTitle)
                ForEach(players) { player in
                    HStack {
                        Text(player.name)
                        Spacer()
                        Button {
                            deletePlayer(player)
                        } label: {
                            Text("❌")
                        }
                    }
                    .frame(width: 256.0)
                }
                AppButton("Add player") {
                    alertPresented = true
                }
            }
            Spacer()
            VStack(spacing: 32) {
                Text("Games:")
                    .font(.largeTitle)
                AppButton("MEMO", isActive: players.count > 0) {
                    memoSizePresented = true
                }
                AppButton("TIC TAC TOE", isActive: players.count == 2) {
                    isTicTacToePresented = true
                }
                AppButton("AIContent") {
                    AIContentPresented = true
                }
            }
            Spacer()
        }
        .fullScreenCover(isPresented: $isMemoPresented) {
            MemoGameView(size: memoSize, players: players, isPresented: $isMemoPresented)
        }
        .fullScreenCover(isPresented: $isTicTacToePresented) {
            TicTacToeView(players: players, isPresented: $isTicTacToePresented)
        }
        .fullScreenCover(isPresented: $AIContentPresented, content: {
            AIContentView()
        })
        .alert("Chose size",isPresented: $memoSizePresented) { // TODO: how to skip this alert ?
            ForEach(2..<9) { n in
                AppButton("\(n)x\(n)            \(resultFor(size: n))") {
                    memoSize = n
                    isMemoPresented = true
                }
            }
            AppButton("Cancel") {
                memoSizePresented = false
            }
        }
        .alert("Add player", isPresented: $alertPresented) {
            TextField("Enter your name", text: $playerToAdd)
            AppButton("Cancel") { }
            AppButton("OK") {
                addPlayer()
            }
        }
        #warning("strange bar at the bottom")
    }
}

struct Player: Identifiable {
    let id: String = UUID().uuidString
    let name: String
    var points = 0
}
