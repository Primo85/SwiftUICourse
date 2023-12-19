import SwiftUI

struct HexGrid<T: View>: View {
    
    private let content: [[T]]
    private let maxRowSize: CGFloat
    private let maxColSize: CGFloat
    private let h: CGFloat = 0.866025
    
    init(content: () -> [[T]]) {
        self.content = content()
        self.maxRowSize = self
            .content
            .map { $0.count }
            .max()
            .map { CGFloat($0) + 0.5 } ?? 0.0
        self.maxColSize = CGFloat(self.content.count)
    }
    
    var body: some View {
        GeometryReader { geom in
            VStack(alignment: .leading, spacing: 0.0) {
                ForEach(0..<content.count) { row in
                    HStack(alignment: .center, spacing: 0.0) {
                        ForEach(0..<content[row].count) { col in
                            let size: CGFloat = min(geom.size.width/maxRowSize, geom.size.height/maxColSize/h)
                            let offset: CGFloat = size/2
                            content[row][col]
                                .frame(width: size,
                                       height: size*h)
                                .offset(x: offset * CGFloat(row%2))
                        }
                    }
                }
            }
        }
    }
}
