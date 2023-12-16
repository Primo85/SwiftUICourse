import SwiftUI

struct AppButton: View {
    
    let title: String
    let isActive: Bool
    let action: () -> Void
    
    init(title: String, isActive: Bool = true, action: @escaping () -> Void) {
        self.title = title
        self.isActive = isActive
        self.action = action
    }
    
    var body: some View {
        Button {
            isActive ? action() : nil
        } label: {
            ButtonLabel(title: title)
                .opacity(isActive ? 1.0 : 0.3)
        }
    }
}
