import Foundation

enum MockData {
    
    private static let names = ["Lorem", "Ipsum", "Dolor", "Sit", "Ament",
                                "Consectetur", "Adipiscing", "Elit"]
    
    static let imgNames = ["globe", "snow", "cloud.sun", "trash",
                           "sailboat", "airplane", "figure.skiing.downhill", "music.quarternote.3",
    ]
    
    static var item: Item {
        Item(name: names.randomElement() ?? "Nothing",
             imageName: imgNames.randomElement() ?? "globe")
    }
    
    static let items: [Item] = {
        var items: [Item] = []
        for _ in 0...12 {
            items.append(item)
        }
        return items
    }()
    
    static let description: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    
    static let animalsCardNames: [String] = ["Rys1","Rys2","Rys3","Rys4","Rys5","Rys6","Rys7","Rys8","Rys9","Rys10",
                                             "Rys11","Rys12","Rys13","Rys14","Rys15","Rys16","Rys17","Rys18","Rys19","Rys20",
                                             "Rys21","Rys22","Rys23","Rys24","Rys25","Rys26","Rys27","Rys28","Rys29","Rys30",
                                             "Rys31","Rys32"]
    
    static func getAnimalCardNames(pairs: Int) -> [String] {
        var result: [String]
        result = animalsCardNames.shuffled()[..<pairs].map { $0 }
        result += result
        return result.shuffled()
    }
    
    static let players: [Player] = [Player(name: "Przemo"),
                                    Player(name: "Karolina"),
                                    Player(name: "Michał")]
    
    static let twoPlayers: [Player] = [Player(name: "Karolina"),
                                     Player(name: "Michał")]
}
