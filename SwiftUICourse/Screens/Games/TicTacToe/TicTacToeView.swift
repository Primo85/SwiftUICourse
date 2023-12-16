import SwiftUI
import Combine

struct TicTacToeView: View {
    
    @StateObject private var viewModel: TicTacToeViewModel
    @Binding private var isPresented: Bool
    
    init(players: [Player], isPresented: Binding<Bool>) {
        self._viewModel = StateObject(wrappedValue: TicTacToeViewModel(players: players))
        self._isPresented = isPresented
    }
    
    var body: some View {
        DynamicStack {
            ZStack {
                DynamicGrid(items: 3) {
                    ForEach(viewModel.cells) { cell in
                        TicTacToeCellView(cell: cell)
                            .onTapGesture {
                                viewModel.click(on: cell.id)
                            }
                    }
                }
                .padding()
                .aspectRatio(1, contentMode: .fill)
                
                if let line = viewModel.line {
                    TicTacToeLine(line: line) { [weak viewModel] in
                        DispatchQueue.main.async {
                            viewModel?.animationComleted.send(true)
                        }
                    }
                }
            }
            
            DynamicStack {
                XdissmissButton(isPresented: $isPresented)
                PlayersResultsView(players: viewModel.players, currentID: viewModel.currentID)
                AppButton("Reset") {
                    viewModel.reset()
                }
            }
            .padding()
        }
        .backgroundGradient()
        // iOS BUG : https://developer.apple.com/forums/thread/738840
        .sheet(isPresented: $viewModel.isSummaryPresented) {
            GameSummaryView(isGamePresented: $isPresented,
                            isSummaryPresented: $viewModel.isSummaryPresented,
                            winnerName: viewModel.winnerName,
                            reset: viewModel.reset)
        }
    }
}
