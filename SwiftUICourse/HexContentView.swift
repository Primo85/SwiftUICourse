import SwiftUI


class HexContentViewModel: ObservableObject {
    
    @Published var table: [[HexCell]] = [[HexCell(number: 1), HexCell(number: 1), HexCell(number: 1)],
                                         [HexCell(number: 1), HexCell(number: 1), HexCell(number: 1), HexCell(number: 1)],
                                         [HexCell(number: 1), HexCell(number: 1), HexCell(number: 1)],
                                         [HexCell(number: 1), HexCell(number: 1), HexCell(number: 1)]]
    
    func click(on id: String) {
        guard let i = table.firstIndex(where: { $0.contains { $0.id == id }}),
              let j = table[i].firstIndex(where: { $0.id == id }) else { return }
        table[i][j].number++
    }
}

struct HexContentView: View {
    
    @StateObject var viewModel = HexContentViewModel()
    
    var body: some View {
        HexGrid {
//            [[HexView(content: Text("DD").font(.largeTitle)), HexView(content: Text("DD").font(.largeTitle)), HexView(content: Text("DD").font(.largeTitle))],
//             [HexView(content: Text("DD").font(.largeTitle)),HexView(content: Text("DD").font(.largeTitle)),HexView(content: Text("DD").font(.largeTitle))],
//             [HexView(content: Text("DD").font(.largeTitle)),HexView(content: Text("DD").font(.largeTitle))],
//             [HexView(content: Text("DD").font(.largeTitle)), HexView(content: Text("DD").font(.largeTitle))]]
            
//            [[Text("DD").font(.largeTitle), Text("DD").font(.largeTitle), Text("DD").font(.largeTitle)],
//             [Text("DD").font(.largeTitle), Text("DD").font(.largeTitle), Text("DD").font(.largeTitle)],
//             [Text("DD").font(.largeTitle), Text("DD").font(.largeTitle), Text("DD").font(.largeTitle)],
//             [Text("DD").font(.largeTitle), Text("DD").font(.largeTitle), Text("DD").font(.largeTitle)]]
            
            viewModel.table.map { row in
                row.map { cell in
                    HexCellView(number: cell.number)
                        .onTapGesture {
                            viewModel.click(on: cell.id)
                        }
                }
            }
        }
        .padding()
        .backgroundGradient()
    }
}

struct HexCellView: View {
    
    let number: Int
    
    var body: some View {
        HexView(
            content:
                Text("\(number)")
                .font(.largeTitle)
        )
    }
}

struct HexCell: Identifiable {
    let id: String = UUID().uuidString
    var number: Int
}
