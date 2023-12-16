import SwiftUI

struct ItemsView: View {
    
    @StateObject var viewModel = ItemsViewModel()
    
    var body: some View {
        LoadingStack(isLoading: viewModel.isLoading) {
            ScrollView {
                AppButton(title: "Fetch Data") { viewModel.fetchData() }
                AppGrid(columns: 3) {
                    ForEach(viewModel.items) { item in
                        ItemPreView(item: item)
                            .onTapGesture {
                                viewModel.selectedEntity = item
                            }
                    }
                }
                .frame(minHeight: 600)
                .padding(.top, 64)
            }
            .navigationTitle("Grid")
            .backgroundGradient()
            .sheet(isPresented: $viewModel.isSelected) {
                ItemDetailsView(item: viewModel.selectedEntity!,
                                isSelected: $viewModel.isSelected,
                                delete: $viewModel.shouldDeleteSelectedEntity)
            }
        }
    }
}

















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsView()
    }
}
