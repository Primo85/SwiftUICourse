import SwiftUI

struct FredboardView: View {
    
    let freadBoard: [Fred]
    
    let action: (Sound) -> Void
    
    var body: some View {
        ScrollView(.horizontal) {
            ZStack {
                HStack(spacing: 0.0) {
                    NutView(fred: freadBoard[0])
                    ForEach(1..<freadBoard.count, id: \.self) { i in
                        FredView(fred: freadBoard[i],
                                 action: action)
                            .frame(width: width(for: i))
                    }
                }
                .backgroundGradient(colors: [.red, .orange])
            }
            .frame(height: 320)
        }
        
    }
    
    func width(for fred: Int) -> CGFloat {
        var width: CGFloat = 210
        for _ in 0..<fred { width *= 0.944 }
        return width
    }
}
