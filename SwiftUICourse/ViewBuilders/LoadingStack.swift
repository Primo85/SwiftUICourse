import SwiftUI

struct LoadingStack<Content: View>: View {
    
    private let isLoading: Bool
    private let content: Content
    
    init(isLoading: Bool, @ViewBuilder _ content: () -> Content) {
        self.isLoading = isLoading
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            content
            if isLoading {
                ProgressView()
                    .controlSize(.large)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .transparentBackground()
            }
        }
    }
}
