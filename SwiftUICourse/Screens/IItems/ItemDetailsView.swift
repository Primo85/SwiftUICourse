import SwiftUI

struct ItemDetailsView: View {
    
    var item: Item
    @Binding var isSelected: Bool
    @State private var isLinkPresented = false
    @Binding var delete: Bool
    
    var body: some View {
        VStack {
            if isSelected {
                XdissmissButton(isPresented: $isSelected)
            }
            ItemPreView(item: item)
            Text(MockData.description)
                .padding()
            AppButton(title: "Open Link") {
                isLinkPresented = true
            }
            #warning("doesnt work for list view")
            AppButton(title: "Delete") {
                delete = true
            }
        }
        .padding()
        .fullScreenCover(isPresented: $isLinkPresented) {
            SafariView(url: URL(string: "https://google.pl")!)
        }
    }
}

struct ItemDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetailsView(item: MockData.item, isSelected: .constant(true), delete: .constant(true))
    }
}
