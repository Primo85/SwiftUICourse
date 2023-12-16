import SwiftUI

struct FredView: View {

    let fred: Fred

    let action: (Sound) -> Void

    var body: some View {
        ZStack {
            VStack(spacing: 60) {
                ForEach(0..<fred.dots, id: \.self) { _ in
                    Circle()
                        .fill(.gray)
                        .frame(width: 45)
                }
            }
            .frame(maxHeight: .infinity)
            HStack(spacing: 0.0) {
                Color.gray
                    .frame(width: 4)
                Color.black
                    .frame(width: 1)
                VStack(spacing: 0.0) {
                    ForEach(0..<fred.notes.count, id: \.self) { i in
                        ZStack {
                            Rectangle()
                                .fill(.white)
                                .frame(maxWidth: .infinity, maxHeight: 1)
                            Button {
                                action(fred.notes[i].sound)
                            } label: {
                                Text(fred.notes[i].symbol)
                                    .frame(maxHeight: .infinity)
                                    .font(.title)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                Color.black
                    .frame(width: 1)
                Color.gray
                    .frame(width: 4)
            }
        }
    }
}
