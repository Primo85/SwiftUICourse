import SwiftUI
import Combine

struct SudokuView: View {
    
    @StateObject var viewModel: SudokuViewModel
    @Binding private var isPresented: Bool
    
    init(size: Size, player: Player, isPresented: Binding<Bool>) {
        self._viewModel = StateObject(wrappedValue: SudokuViewModel(size: size, player: player))
        self._isPresented = isPresented
    }
    
    var body: some View {
        DynamicStack {
            ZStack {
                DynamicGrid(items: viewModel.size.x) {
                    ForEach((1...viewModel.rowSize), id: \.self) { _ in
                        Rectangle()
                            .fill( Color.appTransparent)
                            .frame(maxWidth: .infinity,
                                   maxHeight: .infinity)
                            .aspectRatio(CGFloat(viewModel.ratio),
                                         contentMode: .fit)
                    }
                }
                .padding()
                .aspectRatio(1, contentMode: .fill)
                DynamicGrid(items: viewModel.rowSize) {
                    ForEach(viewModel.cells) { sudoku in
                        SudokuCellView(sudoku: sudoku)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                viewModel.click(on: sudoku.id)
                            }
                    }
                }
                .padding()
                .aspectRatio(1, contentMode: .fill)
            }
            
            DynamicStack {
                XdissmissButton(isPresented: $isPresented)
                Text("Wins  \(viewModel.successes)")
                Text("Fails \(viewModel.fails)")
                Text(viewModel.status)
                    .font(.system(size: 64.0, weight: .heavy))
                    .padding()
                SudokuKeyboardView(size: viewModel.size,
                              tapNumber: viewModel.sendValue(_:))
                    .padding()
            }
        }
        .backgroundGradient()
        .sheet(isPresented: $viewModel.isSummaryPresented) {
            GameSummaryView(isGamePresented: $isPresented,
                            isSummaryPresented: $viewModel.isSummaryPresented,
                            result: viewModel.result.value,
                            reset: viewModel.reset)
        }
    }
}

struct SudokuCellView: View {
    
    let sudoku: Sudoku
    
    var body: some View {
        Text(sudoku.display)
            .font(.system(size: 32.0, weight: .heavy))
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity)
            .aspectRatio(1, contentMode: .fit)
            .if(sudoku.isSelected) { v in
                v.transparentBackground()
            }
    }
}

struct SudokuKeyboardView: View {
    
    let size: Size
    var tapNumber: (Int?) -> ()
    
    var body: some View {
        DynamicGrid(items: size.x) {
            ForEach((1...size.x*size.y), id: \.self) { x in
                Text("\(x)")
                    .font(.system(size: 32.0, weight: .heavy))
                    .frame(maxWidth: .infinity,
                           maxHeight: .infinity)
                    .aspectRatio(1, contentMode: .fit)
                    .transparentBackground()
                    .onTapGesture {
                        tapNumber(x)
                    }
            }
            Text("X")
                .font(.system(size: 32.0, weight: .heavy))
                .frame(maxWidth: .infinity,
                       maxHeight: .infinity)
                .aspectRatio(1, contentMode: .fit)
                .transparentBackground()
                .onTapGesture {
                    tapNumber(nil)
                }
        }
        .aspectRatio(contentMode: .fit)
    }
}

#Preview {
    SudokuView(size: (2, 2), player: Player(name: "f"), isPresented: .constant(true))
}
