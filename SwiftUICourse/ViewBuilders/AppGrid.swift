import SwiftUI

struct AppGrid<Content: View>: View {
    
    private let colums: [GridItem]
    private let content: Content
    
    init(columns n: Int, @ViewBuilder _ content: () -> Content) {
        self.colums = Array(repeating: GridItem(.flexible()), count: n)
        self.content = content()
    }
    
    var body: some View {
        LazyVGrid(columns: colums) {
            content
        }
    }
}
