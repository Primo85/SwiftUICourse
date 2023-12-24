import SwiftUI
import Combine

struct MemoTestView: View {
    
    @StateObject var viewModel: MemoTestViewModel
    @Binding private var isPresented: Bool
    
    init(player: Player, isPresented: Binding<Bool>) {
        self._viewModel = StateObject(wrappedValue: MemoTestViewModel(player: player))
        self._isPresented = isPresented
    }
    
    var body: some View {
        DynamicStack {
            DynamicGrid(items: viewModel.size.value) {
                ForEach(viewModel.table) { card in
                    ZStack {
                        Rectangle()
                            .fill(card.resolved ? Color.clear : Color.appTransparent)
                            .frame(maxWidth: .infinity,
                                   maxHeight: .infinity)
                            .aspectRatio(1, contentMode: .fit)
                        if card.visibleContent == .solid {
                            Rectangle()
                                .fill(Color.blue)
                                .frame(maxWidth: .infinity,
                                       maxHeight: .infinity)
                                .aspectRatio(1, contentMode: .fit)
                                .padding()
                        } else if card.visibleContent == .failed {
                            Rectangle()
                                .fill(Color.red)
                                .frame(maxWidth: .infinity,
                                       maxHeight: .infinity)
                                .aspectRatio(1, contentMode: .fit)
                                .padding()
                        }
                    }
                    .onTapGesture {
                        viewModel.click(on: card.id)
                    }
                }
            }
            .padding()
            .aspectRatio(1, contentMode: .fill)
            
            DynamicStack {
                XdissmissButton(isPresented: $isPresented)
                // TODO: add timer feature
                Text(viewModel.failures)
                Text(viewModel.succesess)
                //                Text("Best result: \(String(viewModel.bestResult) ?? "-")")
                //                PlayersResultsView(players: viewModel.players, currentID: viewModel.currentID)
            }
            .padding()
        }
        .backgroundGradient()
        .sheet(isPresented: $viewModel.isSummaryPresented) {
                        GameSummaryView(isGamePresented: $isPresented,
                                        isSummaryPresented: $viewModel.isSummaryPresented,
                                        result: viewModel.result.value,
                                        reset: viewModel.reset) {
                            PercentageView(suc: viewModel.successCounter.value,
                                           fails: viewModel.failureCounter.value)
                        }
        }
    }
}

struct PercentageView: View {
    
    let suc: Int
    let fails: Int
    
    let midAngle: Angle
    
    init(suc: Int, fails: Int) {
        self.suc = suc
        self.fails = fails
        self.midAngle = Angle(degrees: Double(360*suc/(suc+fails))-90)
    }
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Path() { p in
                    p.addArc(center: CGPoint(x: proxy.size.width/2,
                                             y: proxy.size.height/2),
                             radius: min(proxy.size.width, proxy.size.height)/3,
                             startAngle: Angle(degrees: 0),
                             endAngle: Angle(degrees: 360),
                             clockwise: false)
                }
                .stroke(Color.red, lineWidth: 32.0)
                Path() { p in
                    p.addArc(center: CGPoint(x: proxy.size.width/2,
                                             y: proxy.size.height/2),
                             radius: min(proxy.size.width, proxy.size.height)/3,
                             startAngle: Angle(degrees: -90),
                             endAngle: midAngle,
                             clockwise: false)
                }
                .stroke(Color.green, lineWidth: 32.0)
                
                Text("\(100*suc/(suc+fails))%")
            }
        }
    }
}
