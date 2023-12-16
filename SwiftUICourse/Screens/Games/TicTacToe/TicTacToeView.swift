import SwiftUI
import Combine

struct TicTacToeView: View {
    
    @StateObject private var viewModel: TicTacToeViewModel
    @Binding private var isPresented: Bool
    
    init(players: [Player], isPresented: Binding<Bool>) {
        self._viewModel = StateObject(wrappedValue: TicTacToeViewModel(players: players))
        self._isPresented = isPresented
        print("init TicTacToeView") // TODO: remove
    }
    
    var body: some View {
        print("render TicTacToeView")
        return DynamicStack { // TODO: remove return
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
                    TicTacToeLine(line: line) {
                        DispatchQueue.main.async {
                            viewModel.animationComleted.send(true)
                        }
                    }
                }
            }
            
            DynamicStack {
                XdissmissButton(isPresented: $isPresented)
                PlayersResultsView(players: viewModel.players, currentID: viewModel.currentID)
                AppButton(title: "Reset") {
                    viewModel.reset()
                }
            }
            .padding()
        }
        .backgroundGradient()
        .sheet(isPresented: $viewModel.isSummaryPresented) {
            GameSummaryView(isGamePresented: $isPresented,
                            isSummaryPresented: $viewModel.isSummaryPresented,
                            winnerName: viewModel.winnerName,
                            reset: viewModel.reset)
        }
    }
}
