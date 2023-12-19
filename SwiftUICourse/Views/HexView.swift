import SwiftUI

struct HexView<T: View>: View {
    
    let content: () -> T
    
    var body: some View {
        ZStack {
            HexShape()
                .fill(Color.appTransparent)
                .scaleEffect(0.97)
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
