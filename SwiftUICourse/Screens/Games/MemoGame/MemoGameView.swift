import SwiftUI
import Combine

struct MemoGameView: View {
    
    @StateObject private var viewModel: MemoGameViewModel
    @Binding private var isPresented: Bool
    
    init(size: Int, players: [Player], isPresented: Binding<Bool>) {
        self._viewModel = StateObject(wrappedValue: MemoGameViewModel(size: size,
                                                                      players: players))
        self._isPresented = isPresented
    }
    
    var body: some View {
        DynamicStack {
            DynamicGrid(items: viewModel.size) {
                ForEach(viewModel.cards) { card in
                    CardView(card: card)
                        .onTapGesture {
                            viewModel.click(on: card.id)
                        }
                }
            }
            .padding()
            .aspectRatio(1, contentMode: .fill)
            
            DynamicStack {
                XdissmissButton(isPresented: $isPresented)
                // TODO: add timer feature
                Text("Fails:       \(viewModel.failCounter)")
                Text("Best result: \(String(viewModel.bestResult) ?? "-")")
                PlayersResultsView(players: viewModel.players, currentID: viewModel.currentID)
                AppButton("Reset") {
                    viewModel.reset()
                }
            }
            .padding()
        }
        .backgroundGradient()
        .sheet(isPresented: $viewModel.isSummaryPresented) {
            GameSummaryView(isGamePresented: $isPresented,
                            isSummaryPresented: $viewModel.isSummaryPresented,
                            result: viewModel.result.value!,
                            reset: viewModel.reset)
        }
#warning("RESOLVE THIS viewModel.result.value!")
    }
}


struct MemoGameView_Previews: PreviewProvider {
    static var previews: some View {
        MemoGameView(size: 4, players: [Player(name: "John")], isPresented: .constant(true))
    }
}
