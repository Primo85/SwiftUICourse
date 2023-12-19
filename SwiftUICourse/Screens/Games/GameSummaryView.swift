import SwiftUI

struct GameSummaryView: View {
    
    @Binding var isGamePresented: Bool
    @Binding var isSummaryPresented: Bool
    
    let result: GameResult
    let reset: () -> Void
    
    private var winEmoji: String { ["😀", "😃", "😁", "😋", "😅"].randomElement()! }
    private var lossEmoji: String { ["😫", "☹️", "😟", "😨", "😥"].randomElement()! }
    
    var body: some View {
        VStack(spacing: 16) {
            switch result {
                case .victory(let winner):
                    Text("Wygrywa \(winner) \(winEmoji)")
                        .font(.largeTitle)
                case .draw:
                    Text("Remis")
                        .font(.largeTitle)
                case .defeat:
                    Text("Przegrana \(lossEmoji)")
                        .font(.largeTitle)
            }
            Text("Czy zagrać jeszcze raz?")
            AppButton("Tak") {
                reset()
                isSummaryPresented = false
            }
            AppButton("Nie") {
                isGamePresented = false
            }
        }
    }
}

enum GameResult: Equatable {
    case victory(String)
    case draw
    case defeat
}
