import SwiftUI

struct ItemsListView: View {
    
    @StateObject var viewModel = ItemsViewModel()
    
    var body: some View {
        LoadingStack(isLoading: viewModel.isLoading) {
            List {
                AppButton("Fetch Data") { viewModel.fetchData() }
                ForEach(viewModel.items) { item in
                    NavigationLink {
                        ItemDetailsView(item: item,
                                        isSelected: $viewModel.isSelected,
                                        delete: $viewModel.shouldDeleteSelectedEntity) // TODO: why is not working ?
                    } label: {
                        ItemListPreView(item: item)
                    }
                }
                .onDelete {
                    viewModel.deleteItem(index: $0)
                }
            }
            .navigationTitle("List")
        }
    }
}

struct ItemsListView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsListView()
    }
}
