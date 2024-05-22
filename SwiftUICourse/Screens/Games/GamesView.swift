import SwiftUI

struct GamesView: View {
    
    @State private var isGuitarPresented: Bool = false
    @State private var isMemoPresented: Bool = false
    @State private var isMemoSizePresented: Bool = false
    @State private var isMemoTestPresented: Bool = false
    @State private var isMathTestPresented: Bool = false
    @State private var isSudokuPresented: Bool = false
    @State private var isSudokuSizePresented: Bool = false
    @State private var isTicTacToePresented: Bool = false
    @State private var AIContentPresented: Bool = false
    @State private var isHexSaperPresented: Bool = false
    @State private var memoSize = 4
    @State private var sudokuSize: Size = (2, 2)
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
                AppButton("GUITAR") {
                    isGuitarPresented = true
                }
                Text("Games:")
                    .font(.largeTitle)
                AppButton("MEMO", isActive: players.count > 0) {
                    isMemoSizePresented = true
                }
                AppButton("TIC TAC TOE", isActive: players.count == 2) {
                    isTicTacToePresented = true
                }
//                AppButton("AIContent") {
//                    AIContentPresented = true
//                }
                AppButton("HEX SAPER", isActive: players.count == 1) {
                    isHexSaperPresented = true
                }
                AppButton("MEMO TEST", isActive: players.count == 1) {
                    isMemoTestPresented = true
                }
                AppButton("SUDOKU", isActive: players.count == 1) {
                    isSudokuSizePresented = true
                }
                AppButton("MATH", isActive: players.count == 1) {
                    isMathTestPresented = true
                }
            }
            Spacer()
        }
        .fullScreenCover(isPresented: $isGuitarPresented) {
            GuitarView(isPresented: $isGuitarPresented)
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
        .fullScreenCover(isPresented: $isHexSaperPresented, content: {
            HexSaperGameView(player: players.first!, isPresented: $isHexSaperPresented)
        })
        .fullScreenCover(isPresented: $isMemoTestPresented) {
            MemoTestView(player: players.first!, isPresented: $isMemoTestPresented)
        }
        .fullScreenCover(isPresented: $isSudokuPresented) {
            SudokuView(size: sudokuSize, player: players.first!, isPresented: $isSudokuPresented)
        }
        .fullScreenCover(isPresented: $isMathTestPresented) {
            MathTestView(player: players.first!, isPresented: $isMathTestPresented)
        }
        .alert("Chose size",isPresented: $isMemoSizePresented) { // TODO: how to skip this alert ?
            ForEach(4..<9) { n in
                AppButton("\(n)x\(n)            \(resultFor(size: n))") {
                    memoSize = n
                    isMemoPresented = true
                }
            }
            AppButton("Cancel") {
                isMemoSizePresented = false
            }
        }
        .alert("Chose size",isPresented: $isSudokuSizePresented) { // TODO: how to skip this alert ?
            AppButton("2x1") { // 2
                sudokuSize = (2, 1)
                isSudokuPresented = true
            }
            AppButton("3x1") { // 3
                sudokuSize = (3, 1)
                isSudokuPresented = true
            }
            AppButton("2x2") { // 4
                sudokuSize = (2, 2)
                isSudokuPresented = true
            }
            AppButton("3x2") { // 6
                sudokuSize = (3, 2)
                isSudokuPresented = true
            }
            AppButton("4x2") {
                sudokuSize = (4, 2)
                isSudokuPresented = true
            }
            AppButton("3x3") {
                sudokuSize = (3, 3)
                isSudokuPresented = true
            }
            AppButton("Cancel") {
                isSudokuSizePresented = false
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
