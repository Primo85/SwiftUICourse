import SwiftUI

struct TicTacToeCellView: View {
    
    let cell: TicTacToecell
    
    var body: some View {
        Text(cell.state.rawValue)
            .font(.system(size: 128.0, weight: .heavy))
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity)
            .aspectRatio(1, contentMode: .fit)
            .transparentBackground()
    }
}
