import SwiftUI

struct GameSummaryView<T: View>: View {
    
    @Binding var isGamePresented: Bool
    @Binding var isSummaryPresented: Bool
    
    let result: GameResult?
    let reset: () -> Void
    let additionalContent: () -> T
    
    init(isGamePresented: Binding<Bool>,
         isSummaryPresented: Binding<Bool>,
         result: GameResult?,
         reset: @escaping () -> Void,
         additionalContent: @escaping () -> T = { EmptyView() } ) {
        self._isGamePresented = isGamePresented
        self._isSummaryPresented = isSummaryPresented
        self.result = result
        self.reset = reset
        self.additionalContent = additionalContent
    }
    
    var body: some View {
        VStack(spacing: 16) {
            switch result {
                case .victory(let winner):
                Text("Wygrywa \(winner) \(String.winEmoji)")
                        .font(.largeTitle)
                case .draw:
                    Text("Remis")
                        .font(.largeTitle)
                case .defeat:
                Text("Przegrana \(String.lossEmoji)")
                        .font(.largeTitle)
                case nil:
                    Text("Koniec gry")
            }
            additionalContent()
            Text("Czy zagrać jeszcze raz?")
            AppButton("Tak") {
                reset()
                isSummaryPresented = false
            }
            AppButton("Nie") {
                isGamePresented = false
            }
        }
        .padding([.bottom, .top], 96.0)
    }
}

enum GameResult: Equatable {
    case victory(player: String)
    case draw
    case defeat
}
