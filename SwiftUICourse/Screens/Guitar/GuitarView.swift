import SwiftUI

struct GuitarView: View {
    
    @StateObject var viewModel: GuitarViewModel = GuitarViewModel()
    @Binding private var isPresented: Bool
    
    init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
    }
    
    var body: some View {
        VStack {
            Text(viewModel.title)
                .font(.largeTitle)
            
            HStack(spacing: 64) {
                Spacer().frame(width: 24)
                CircleOf5th(radious: 120,
                            selected: viewModel.scale.key,
                            action: viewModel.changeKey)
                XdissmissButton(isPresented: $isPresented)
                ScalesView(selectedScale: viewModel.scale.type,
                           action: viewModel.changeScaleType)
                Spacer()
            }

            FredboardView(freadBoard: viewModel.freadBoard, action: viewModel.select)
        }
    }
}

struct ScalesView: View {
    
    let selectedScale: Scale.ScaleType
    let action: (Scale.ScaleType) -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            ForEach(0..<Scale.ScaleType.allCases.count, id: \.self) { i in
                Button {
                    action(Scale.ScaleType.allCases[i])
                } label: {
                    ZStack {
//                        if Scale.ScaleType.allCases[i] == selectedScale {
//                            Color.black
//                        }
                        Text(Scale.ScaleType.allCases[i].rawValue)
                    }
                }
            }
        }
    }
}










































struct GuitarView_Previews: PreviewProvider {
    static var previews: some View {
        GuitarView(isPresented: .constant(true))
//            .previewInterfaceOrientation(.landscapeLeft)
    }
}
