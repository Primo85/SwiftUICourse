import SwiftUI
import Combine

final class ZipCombineLatestViewModel: ObservableObject {
    
    @Published var textA: String = ""
    @Published var textB: String = ""
    @Published var zip: String = ""
    @Published var com: String = ""
    
    let subjectA = CurrentValueSubject<Int, Never>(0)
    let subjectB = CurrentValueSubject<Int, Never>(0)
    
    init() {
        subjectA
            .map { "\($0)" }
            .assign(to: &$textA)
        
        subjectB
            .map { "\($0)" }
            .assign(to: &$textB)
        
        subjectA
            .combineLatest(subjectA)
            .map { "\($0) \($1)" }
            .assign(to: &$com)
        
        subjectA
            .zip(subjectA)
            .map { "\($0) \($1)" }
            .assign(to: &$zip)
        
    }
    
    func increaseA() {
        subjectA.value++
    }
    
    func increaseB() {
        subjectB.value++
    }
}

struct ZipCombineLatestView: View {
    
    @StateObject var viewModel = ZipCombineLatestViewModel()
    
    var body: some View {
        VStack {
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
            Text("combine latest:")
            Text(viewModel.zip)
                .font(.largeTitle)
            Text("zip:")
            Text(viewModel.com)
                .font(.largeTitle)
        }
    }
}
