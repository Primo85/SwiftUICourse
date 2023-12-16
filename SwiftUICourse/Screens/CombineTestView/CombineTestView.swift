import SwiftUI
import Combine

struct CombineTestView: View {
    
    @StateObject var viewModel = CombineTestViewModel()
    
    var body: some View {
        VStack {
            Text(viewModel.text1)
            Text(viewModel.text2)
            Text(viewModel.text3)
            AppButton("INCREASE") {
                viewModel.increase()
            }
            AppButton("TOGGLE") {
                viewModel.toggle()
            }
            AppButton("COMPLETION") {
                viewModel.completion()
            }
            AppButton("CANCEL") {
                viewModel.cancel()
            }
        }
    }
}































































struct CombineTestView_Previews: PreviewProvider {
    static var previews: some View {
        CombineTestView()
    }
}

