import SwiftUI
import Combine

struct CombineTestView: View {
    
    @StateObject var viewModel = CombineTestViewModel()
    @Binding private var isPresented: Bool
    
    init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
    }
    
    var body: some View {
        VStack {
            AppButton("Zip CombineLAtest demo") {
                viewModel.isZipCombineLAtestPresented = true
            }
        }
        .fullScreenCover(isPresented: $viewModel.isZipCombineLAtestPresented) {
            ZipCombineLatestView(isPresented: $viewModel.isZipCombineLAtestPresented)
        }
    }
}































































struct CombineTestView_Previews: PreviewProvider {
    static var previews: some View {
        CombineTestView()
    }
}

