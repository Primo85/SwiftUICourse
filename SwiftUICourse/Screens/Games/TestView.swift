import SwiftUI
import Combine

struct TestView: View {
    
    @StateObject var viewModel = TestViewModel()
    
    var body: some View {
        DGrid(items: .columns(3)) {
            ForEach((1..<100)) { i in
                Text("TestView \(i)")
                    .padding()
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .aspectRatio(1, contentMode: .fit)
                    .backgroundGradient()
            }
        }
    }
}

struct DGrid<Content: View>: View {
    
    enum GridOrientation {
        case rows(Int)
        case columns(Int)
    }
    
    private let orientation: GridOrientation
    private let content: Content
    
    init(items orientation: GridOrientation, @ViewBuilder _ content: () -> Content) {
        self.orientation = orientation
        self.content = content()
    }
    
    var body: some View {
        ScrollView {
            switch orientation {
            case .rows(let n):
                let items = Array(repeating: GridItem(.flexible()), count: n)
                LazyHGrid(rows: items) { content }
            case .columns(let n):
                let items = Array(repeating: GridItem(.flexible()), count: n)
                LazyVGrid(columns: items) { content }
            }
        }
    }
}

#Preview {
    TestView()
}
