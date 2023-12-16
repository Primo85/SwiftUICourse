import SwiftUI

struct DynamicGrid<Content: View>: View {
    
    private let items: [GridItem]
    private let content: Content
    
    init(items n: Int, @ViewBuilder _ content: () -> Content) {
        self.items = Array(repeating: GridItem(.flexible()), count: n)
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { proxy in
            if proxy.size.width > proxy.size.height {
                LazyHGrid(rows: items) {
                    content
                }
            } else {
                LazyVGrid(columns: items) {
                    content
                }
            }
        }
    }
}
