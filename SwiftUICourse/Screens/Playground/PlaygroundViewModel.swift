import SwiftUI
//import Combine

final class PlaygroundViewModel: ObservableObject {
    
    @Published var backGr = Color.blue
    @Published var timer = 0
    
    init() {
        bind()
//        increaseTimer()
    }
    
    private func bind() {
        
    }
    
    private func increaseTimer() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            print("increase timer")
            self?.timer++
            self?.increaseTimer()
        }
    }
}

class Counter {
    private var c = 0
    var value: Int {
        c++
        return c
    }
    init() {
        print("init counter")
    }
    deinit {
        print("deinit counter")
    }
}
