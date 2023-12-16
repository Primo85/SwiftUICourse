import SwiftUI

struct PlayersResultsView: View {
    
    let players: [Player]
    let currentID: String
    
    var body: some View {
        VStack(spacing: 32.0) {
            ForEach(players) { player in
                HStack {
                    Spacer()
                    if player.id == currentID {
                        Circle()
                            .frame(width: 16)
                    }
                    Text(player.name)
                        .frame(width: 128.0, alignment: .leading)
                    Text("\(player.points)")
                        .frame(width: 32.0, alignment: .leading)
                }
                .font(.title)
                .padding()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct PlayersResultsView_Previews: PreviewProvider {
    static var previews: some View {
        PlayersResultsView(players: MockData.players,
                           currentID: MockData.players[0].id)
    }
}
