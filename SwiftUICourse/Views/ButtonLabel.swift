import SwiftUI

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

struct ButtonLabel_Previews: PreviewProvider {
    static var previews: some View {
        ButtonLabel(title: "Some title")
    }
}
