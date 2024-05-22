import SwiftUI

struct AppButton: View {
    
    let title: String
    let isActive: Bool
    let action: () -> Void
    
    init(_ title: String, isActive: Bool = true, action: @escaping () -> Void) {
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

struct LongPressButton: View {
    
    let title: String
    let isActive: Bool
    let action: () -> Void
    
    init(_ title: String, isActive: Bool = true, action: @escaping () -> Void) {
        self.title = title
        self.isActive = isActive
        self.action = action
    }
    
    var body: some View {
        ButtonLabel(title: title)
            .opacity(isActive ? 1.0 : 0.3)
            .onLongPressGesture(minimumDuration: 2) {
                isActive ? action() : nil
            }
    }
}

struct ButtonLabel: View {
    
    let title: String
    
    var body: some View {
        Text(title)
            .frame(width: 128, height: 40)
            .backgroundGradient()
            .cornerRadius(16)
            .accentColor(Color(.label))
    }
}
