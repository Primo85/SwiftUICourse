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
                Button("Randomize number") {
                    viewModel.randomNumber = (0..<1000).randomElement()!
                }
                Text("Count is: \(viewModel.count)")
                Button("Increment Counter") {
                    viewModel.incrementCounter()
                }
                Spacer()
                AnimatedView()
                Spacer()
            }
            
            MyShape(scale: viewModel.scale)
            .stroke(lineWidth: 12.0)
            .animation(.linear(duration: 3), value: viewModel.scale)
        }
    }
}

struct AnimatedView: View {
    @State private var rotationAngle: Double = 0
    
    var body: some View {
        Rectangle()
            .fill(Color.blue)
            .frame(width: 200, height: 200)
            .rotationEffect(.degrees(rotationAngle))
            .animation(.linear(duration: 1)) // Add the animation modifier here
            .onAppear {
                print("onAppear")
                self.rotationAngle += 360 // Change the property to trigger animation
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
