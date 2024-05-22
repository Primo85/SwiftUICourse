import SwiftUI

struct HexView<T: View>: View {
    
    let color: Color
    let scale: CGFloat
    
    let content: () -> T
    
    init(color: Color = .appTransparent, scale: CGFloat = 0.97, content: @escaping () -> T) {
        self.color = color
        self.scale = scale
        self.content = content
    }
    
    var body: some View {
        ZStack {
            HexShape()
                .fill(color)
                .scaleEffect(scale)
            content()
        }
    }
    
    private struct HexShape: Shape {
        func path(in rect: CGRect) -> Path {
            Path { p in
                p.move(to: CGPoint(x: rect.midX, y: rect.height*7/6))
                p.addLine(to: CGPoint(x: rect.maxX, y: rect.height*5/6))
                p.addLine(to: CGPoint(x: rect.maxX, y: rect.height*1/6))
                p.addLine(to: CGPoint(x: rect.midX, y: -rect.height*1/6))
                p.addLine(to: CGPoint(x: rect.minX, y: rect.height*1/6))
                p.addLine(to: CGPoint(x: rect.minX, y: rect.height*5/6))
                p.closeSubpath()
            }
        }
    }
}
