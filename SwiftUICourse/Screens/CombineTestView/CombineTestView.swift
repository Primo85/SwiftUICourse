import SwiftUI
import Combine

struct CombineTestView: View {
    
    @StateObject var viewModel = CombineTestViewModel()
    
    var body: some View {
        VStack {
            Text(viewModel.text1)
            Text(viewModel.text2)
            Text(viewModel.text3)
            AppButton(title: "INCREASE") {
                viewModel.increase()
            }
            AppButton(title: "TOGGLE") {
                viewModel.toggle()
            }
            AppButton(title: "COMPLETION") {
                viewModel.completion()
            }
            AppButton(title: "CANCEL") {
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

