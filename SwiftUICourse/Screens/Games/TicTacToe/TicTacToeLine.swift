import SwiftUI
import Combine

enum TicTacToeLineType {
    case x(CGFloat)
    case y(CGFloat)
    case d1, d2
}

struct TicTacToeLine: View {
    
    let line: TicTacToeLineType
    @State var scale: CGFloat = 0.0
    var animationComleted: () -> ()
    
    init(line: TicTacToeLineType, animationComleted: @escaping () -> ()) {
        print("init MyLine")
        self.line = line
        self.animationComleted = animationComleted
    }
    
    private func animate() {
        withAnimation(.linear(duration: 1)) {
            scale = 1.0
        } completion: {
            print("animation done")
            animationComleted()
        }
    }
    
    var body: some View {
        print("render MyLine")
        return LineShape(line: line, scale: scale)
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
            print("init line \(self.line) \(self.scale)")
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
