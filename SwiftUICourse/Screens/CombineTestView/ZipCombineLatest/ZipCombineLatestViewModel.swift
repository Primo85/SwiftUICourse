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
            .combineLatest(subjectB)
            .map { "\($0) \($1)" }
            .assign(to: &$com)
        
        subjectA
            .zip(subjectB)
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
