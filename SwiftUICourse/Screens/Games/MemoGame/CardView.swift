import SwiftUI

struct CardView: View {
    
    let card: Card
    
    var body: some View {
        Image(card.fileName)
            .resizable()
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity)
            .aspectRatio(1, contentMode: .fit)
            .opacity(card.state == .resolved ? 0.3 : 1.0)
    }
}
