import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                AppGrid(columns: 3) {
                    NavigationLink {
                        ItemsView()
                    } label: {
                        ItemPreView(item: Item(name: "Grid",
                                               imageName: "square.grid.3x3"))
                    }
                    NavigationLink {
                        ItemsListView()
                    } label: {
                        ItemPreView(item: Item(name: "List",
                                               imageName: "list.bullet"))
                    }
                    NavigationLink {
                        GamesView()
                    } label: {
                        ItemPreView(item: Item(name: "Games",
                                               imageName: "globe"))
                    }
                    NavigationLink {
                        QRscannerView()
                    } label: {
                        ItemPreView(item: Item(name: "QR scanner",
                                               imageName: "qrcode.viewfinder"))
                    }
                    NavigationLink {
                        GuitarView(isPresented: .constant(true))
                    } label: {
                        ItemPreView(item: Item(name: "Fredboard",
                                               imageName: "guitars"))
                    }
//                    NavigationLink {
//                        GuitarView()
//                    } label: {
//                        ItemPreView(item: Item(name: "Fredboard",
//                                               imageName: "guitars"))
//                    }
                    NavigationLink {
                        CombineTestView()
                    } label: {
                        ItemPreView(item: Item(name: "Combine",
                                               imageName: "engine.combustion"))
                    }
                }
            }
            .backgroundGradient()
            .navigationTitle("Main")
        }
        .accentColor(Color(.label))
    }
}





struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
