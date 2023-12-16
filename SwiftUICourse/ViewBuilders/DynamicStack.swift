import SwiftUI

struct DynamicStack<Content: View>: View {
    
    private let content: Content
    
    init(@ViewBuilder _ content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { proxy in
            if proxy.size.width > proxy.size.height {
                HStack { content }
            } else {
                VStack { content }
            }
        }
    }
}
