import SwiftUI
import Combine

struct ZipCombineLatestView: View {
    
    @StateObject var viewModel = ZipCombineLatestViewModel()
    @Binding private var isPresented: Bool
    
    init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
    }
    
    var body: some View {
        VStack {
            XdissmissButton(isPresented: $isPresented)
            HStack {
                VStack {
                    Text(viewModel.textA)
                        .font(.largeTitle)
                    AppButton("➕") {
                        viewModel.increaseA()
                    }
                }
                VStack {
                    Text(viewModel.textB)
                        .font(.largeTitle)
                    AppButton("➕") {
                        viewModel.increaseB()
                    }
                }
            }
            .padding(.bottom)
            Text("combine latest:")
            Text(viewModel.com)
                .font(.largeTitle)
                .padding(.bottom)
            Text("zip:")
            Text(viewModel.zip)
                .font(.largeTitle)
        }
    }
}
