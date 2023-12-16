import SwiftUI

struct TestView: View {
    
    
    var body: some View {
        CounterView()
    }
}

final class CounterViewModel: ObservableObject {
    
    @Published var count = 0
    @Published var randomNumber = 0
    @Published var scale: CGFloat = 1.0
    
    func incrementCounter() {
        count++
        scale = CGFloat(count%3)
    }
}



struct CounterView: View {
    @StateObject var viewModel = CounterViewModel()
    
    var body: some View {
        ZStack {
            VStack(spacing: 32) {
                Spacer()
                Text("Random number is: \(viewModel.randomNumber)")
                AppButton("Randomize number") {
                    viewModel.randomNumber = (0..<1000).randomElement()!
                }
                Text("Count is: \(viewModel.count)")
                AppButton("Increment Counter") {
                    viewModel.incrementCounter()
                }
                AppButton("TEST") {
                    ContolFlow.breakingLoop()
                }
                Spacer()
            }
            
            MyShape(scale: viewModel.scale)
            .stroke(lineWidth: 12.0)
            .animation(.linear(duration: 3), value: viewModel.scale)
        }
    }
}

struct MyShape: Shape {
    
    var scale: CGFloat
    
    var animatableData: CGFloat {
            get { scale }
            set { scale = newValue }
        }
    
    func path(in rect: CGRect) -> Path {
        Path { p in
            p.move(to: CGPoint(x: 10, y: 400))
            p.addLine(to: CGPoint(x: scale*200, y: 400))
        }
    }
}
