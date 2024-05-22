import SwiftUI

final class ItemsViewModel: ObservableObject {
    
    init() {
        fetchData()
    }
    
    @Published var items: [Item] = []
    @Published var isSelected: Bool = false
    @Published var isLoading: Bool = false
    
    func fetchData() {
        let newItems = [MockData.item, MockData.item, MockData.item, MockData.item]
        
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.items.append(contentsOf: newItems)
            self?.isLoading = false
        }
    }
    
    func deleteItem(index: IndexSet) {
        items.remove(atOffsets: index)
    }
    
    func deleteItem(id: String) {
        items.removeAll { $0.id == id }
    }
    
    var selectedEntity: Item? {
        didSet {
            isSelected = selectedEntity != nil
        }
    }
    var shouldDeleteSelectedEntity: Bool = false {
        didSet {
            items.removeAll { $0.id == selectedEntity?.id }
            shouldDeleteSelectedEntity = false
            isSelected = false
        }
    }
}
