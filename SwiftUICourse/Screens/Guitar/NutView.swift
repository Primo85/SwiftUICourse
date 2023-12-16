import SwiftUI

struct NutView: View {
    let fred: Fred
    
    var body: some View {
        HStack(spacing: 0.0) {
            Color.gray
                .frame(width: 5)
            VStack(spacing: 0.0) {
                ForEach(fred.notes) { note in
                    ZStack {
                        Rectangle()
                            .fill(.white)
                            .frame(maxWidth: .infinity, maxHeight: 1)
                        Text(note.symbol)
                            .frame(maxHeight: .infinity)
                            .font(.title)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            Color.black
                .frame(width: 2)
        }
    }
}
