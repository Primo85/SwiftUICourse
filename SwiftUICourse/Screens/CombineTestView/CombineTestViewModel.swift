import SwiftUI
import Combine

var globalCounter = 0

final class CombineTestViewModel: ObservableObject {
    
    @Published var text1: String = "Let's start"
    @Published var text2: String = "Let's start"
    @Published var text3: String = "Let's start"
    
    let ptSubject = PassthroughSubject<Int, Never>()
    let cvSubject = CurrentValueSubject<Int, Never>(0)
    var cancellables = Set<AnyCancellable>()
    
    init() {
        ptSubject
            .map { "C: \($0)" }
            .assign(to: &$text1)
        
        cvSubject
            .map { "counter: \($0)"}
            .sink(receiveCompletion: { [weak self] in
                switch $0 {
                    case .finished:
                        self?.text2 = "kuniec!"
                    case .failure:
                        self?.text2 = "some error"//error.description
                }
            },
            receiveValue: { [weak self] in self?.text2 = $0 })
            .store(in: &cancellables)
        
        cvSubject
            .combineLatest(ptSubject)
            .filter { a,b in a % 2 == 0 }
            .map { "\($0) \($1)" }
            .assign(to: &$text3)
        
        Just("All is binded")
            .assign(to: \.text1, on: self)
            .cancel()
        
        Just("It just works!")
            .assign(to: \.text2, on: self)
            .cancel()
    }
    
    func increase() {
        cvSubject.value++
    }
    
    func toggle() {
        globalCounter++
        ptSubject.send(globalCounter)
    }
    
    func completion() {
//        cvSubject.send(completion: .failure(SomeError(description: "dupa 8")))
        cvSubject.send(completion: .finished)
    }
    
    func cancel() {
        cancellables.forEach { $0.cancel() }
    }
}
