import SwiftUI

struct CircleOf5th: View {
    
    let items = Tunes.circleOf5th
    let radious: Double
    let angle: Double
    let selected: Sound
    
    let action: (Sound) -> Void
    
    init(radious: Double, selected: Sound, action: @escaping (Sound) -> Void) {
        self.radious = radious
        self.angle = 3.1415*2/Double(items.count)
        self.action = action
        self.selected = selected
    }
    
    func offset(for i: Int) -> CGSize {
        CGSize(width: radious*sin(Double(i)*angle),
               height: -radious*cos(Double(i)*angle))
    }
    
    var body: some View {
        ZStack {
            ForEach(0..<items.count, id: \.self) { i in
                if items[i] == selected {
                    Circle()
                        .frame(width: 40)
                        .offset(offset(for: i))
                }
                Button {
                    action(items[i])
                } label: {
                    Text(items[i].symbol)
                        .font(.largeTitle)
                }
                .offset(offset(for: i))
            }
        }
        .frame(width: 2*radious, height: 2*radious)
        .background(RadialGradient(colors: [.orange, .orange, .orange, .clear], center: .center, startRadius: 0, endRadius: radious))
    }
}
