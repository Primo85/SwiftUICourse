import SwiftUI
import Combine

struct TicTacToeLineView: View {
    
    let line: TicTacToeLineType
    @State var scale: CGFloat = 0.0
    
    init(line: TicTacToeLineType) {
        self.line = line
    }
    
    private func animate() {
        if #available(iOS 17.0, *) { // TODO: remove this and increase target ver after fix iOS 17 memory leak
            withAnimation(.linear(duration: 1)) {
                scale = 1.0
            }
        } else {
            scale = 1.0
        }
    }
    
    var body: some View {
        LineShape(line: line, scale: scale)
            .stroke(lineWidth: 12.0)
            .onAppear() {
                animate()
            }
    }
    
    private struct LineShape: Shape {
        
        let line: TicTacToeLineType
        
        var scale: CGFloat
        
        init(line: TicTacToeLineType, scale: CGFloat) {
            self.line = line
            self.scale = scale
        }
        
        var animatableData: CGFloat {
            get { scale }
            set { scale = newValue }
        }
        
        
        private func points(_ frame: CGRect) -> (CGPoint, CGPoint) {
            return switch line {
                case .x(let x):
                    (CGPoint(x: frame.maxX*(x*2+1)/6, y: 0.0),
                     CGPoint(x: frame.maxX*(x*2+1)/6, y: frame.maxY*scale))
                case .y(let y):
                    (CGPoint(x: 0.0, y: frame.maxY*(y*2+1)/6),
                     CGPoint(x: frame.maxX*scale, y: frame.maxY*(y*2+1)/6))
                case .d1:
                    (CGPoint(x: 0.0, y: 0.0),
                     CGPoint(x: frame.maxX*scale, y: frame.maxY*scale))
                case .d2:
                    (CGPoint(x: 0.0, y: frame.maxY),
                     CGPoint(x: frame.maxX*scale, y: frame.maxY*(1-scale)))
            }
        }
        
        func path(in rect: CGRect) -> Path {
            Path { path in
                let points = points(rect)
                path.move(to: points.0)
                path.addLine(to: points.1)
            }
        }
    }
}
