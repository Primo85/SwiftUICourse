import SwiftUI

struct ItemListPreView: View {
    var item: Item
    
    var body: some View {
        HStack {
            Image(systemName: item.imageName)
                .resizable()
                .scaledToFit()
            .frame(width: 50, height: 70)
            Text(item.name)
                .padding()
        }
        .padding()
    }
}

struct ItemListPreView_Previews: PreviewProvider {
    static var previews: some View {
        ItemListPreView(item: MockData.item)
    }
}
