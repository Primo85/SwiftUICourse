import SwiftUI

struct ItemPreView: View {
    var item: Item
    
    var body: some View {
        VStack {
            Image(systemName: item.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 70)
            Text(item.name)
                .padding()
                .lineLimit(1)
        }
        .padding()
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemPreView(item: MockData.item)
    }
}
