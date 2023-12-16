import SwiftUI

struct GameSummaryView: View {
    
    @Binding var isGamePresented: Bool
    @Binding var isSummaryPresented: Bool
    
    let winnerName: String?
    let reset: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            if let winnerName = winnerName {
                Text("Wygrywa \(winnerName)")
                    .font(.largeTitle)
            } else {
                Text("Remis")
                    .font(.largeTitle)
            }
            Text("Czy zagrać jeszcze raz?")
            AppButton(title: "Tak") {
                reset()
                isSummaryPresented = false
            }
            AppButton(title: "Nie") {
                isGamePresented = false
            }
        }
    }
}
