import SwiftUI
import Combine

struct MathTestView: View {
    
    @StateObject var viewModel: MathTestViewModel
    @Binding private var isPresented: Bool
    
    init(player: Player, isPresented: Binding<Bool>) {
        self._viewModel = StateObject(wrappedValue: MathTestViewModel(player: player))
        self._isPresented = isPresented
    }
    
    var body: some View {
        DynamicStack {
            DynamicStack {
                Text(viewModel.text)
                    .font(.system(size: 64.0, weight: .heavy))
//                Spacer()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .if(viewModel.isCorrect == true) { $0.foregroundColor(.green) }
                    .if(viewModel.isCorrect == false) { $0.foregroundColor(.red) }
                NumberPadView(tapNumber: viewModel.tapOn(action:))
            }
            DynamicGrid(items: 10) {
                ForEach(viewModel.table) { cell in
                    Rectangle()
                        .aspectRatio(1, contentMode: .fill)
                        .padding(0.5)
                        .opacity(cell.value ? 0.5 : 0.1)
                        .onTapGesture {
                            print("R")
                            viewModel.tapOn(id: cell.id)
                        }
                }
            }
            .aspectRatio(contentMode: .fill)
        }
        .backgroundGradient()
        .sheet(isPresented: $viewModel.isSummaryPresented) {
                        GameSummaryView(isGamePresented: $isPresented,
                                        isSummaryPresented: $viewModel.isSummaryPresented,
                                        result: viewModel.result.value,
                                        reset: viewModel.reset) {
                            PercentageView(suc: viewModel.successCounter.value,
                                           fails: viewModel.failureCounter.value)
                        }
        }
    }
}

#Preview {
    MathTestView(player: Player(name: "John"), isPresented: .constant(false))
}

struct NumberPadView: View {
    
    var tapNumber: (NumberPadAction) -> ()
    
    var body: some View {
        DynamicStack {
            DGrid(items: .columns(3)) {
                ForEach((1...9), id: \.self) { x in
                    Text("\(x)")
                        .font(.system(size: 32.0, weight: .heavy))
                        .frame(maxWidth: .infinity,
                               maxHeight: .infinity)
                        .aspectRatio(1, contentMode: .fill)
                        .transparentBackground()
                        .onTapGesture {
                            tapNumber(.number(x))
                        }
                }
                ForEach(["<", "0", "E"], id: \.self) { symbol in
                    Text(symbol)
                        .font(.system(size: 32.0, weight: .heavy))
                        .frame(maxWidth: .infinity,
                               maxHeight: .infinity)
                        .aspectRatio(1, contentMode: .fill)
                        .transparentBackground()
                        .onTapGesture {
                            switch symbol {
                            case "<": tapNumber(.delete)
                            case "0": tapNumber(.number(0))
                            case "E": tapNumber(.enter)
                            default: break
                            }
                        }
                }
            }
        }
        .padding()
        .aspectRatio(0.7, contentMode: .fill)
        .transparentBackground()
    }
}

enum NumberPadAction {
    case number(Int)
    case delete
    case enter
}
