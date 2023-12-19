import SwiftUI

struct HexSaperGameView: View {
    
    @StateObject var viewModel: HexSaperGameViewModel
    @Binding private var isPresented: Bool
    
    init(player: Player, isPresented: Binding<Bool>) {
        self._viewModel = StateObject(wrappedValue: HexSaperGameViewModel(player: player))
        self._isPresented = isPresented
    }
    
    var body: some View {
        DynamicStack {
            HexGrid {
                viewModel.table.map { row in
                    row.map { cell in
                        SaperHexView(hex: cell, mark: viewModel.mark)
                            .onTapGesture {
                                viewModel.click(cell.id)
                            }
                    }
                }
            }
            .padding()
            .aspectRatio(1, contentMode: .fill)
            
            DynamicStack {
                XdissmissButton(isPresented: $isPresented)
                // TODO: add timer feature
                // TODO: add number of bomb
                Text("Bomb  \(viewModel.bombCount)")
                Text("Wins  \(viewModel.successes)")
                Text("Fails \(viewModel.fails)")
                AppButton("Reset") {
                    viewModel.reset()
                }
            }
//            .padding()
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

struct SaperHexView: View {
    
    let hex: SaperHex
    
    let mark: (String) -> ()
    
    private var text: String {
        switch hex.state {
            case .marked, .unmarked:
                " "
            case .discover(let x):
                hex.hasBomb ? "💣" : x == 0 ? " " : "\(x)"
        }
    }
    
    private var markedFlag: String {
        switch hex.state {
            case .marked:
                "🏴"
            case .unmarked:
                "🏳️"
            case .discover:
                ""
        }
    }
    
    var body: some View {
        HexView {
            VStack() {
                HStack {
                    Spacer()
                    Button {
                        mark(hex.id)
                    } label: {
                        Text(markedFlag)
                            .font(.system(size: 64.0))
                    }
                }
                Text(text)
                    .font(.system(size: 64.0, weight: .heavy))
            }
        }
    }
}
