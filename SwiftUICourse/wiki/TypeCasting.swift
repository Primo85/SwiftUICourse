import Foundation

class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}
class SomeAbstractItemInTheMiddle: MediaItem { }
class Movie: SomeAbstractItemInTheMiddle {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}
class Song: SomeAbstractItemInTheMiddle {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}
    
// .... it works ass well
//protocol MediaItem {
//    var name: String { get set }
//}
//struct Movie: MediaItem {
//    var name: String
//    var director: String
//    init(name: String, director: String) {
//        self.name = name
//        self.director = director
//    }
//}
//struct Song: MediaItem {
//    var name: String
//    var artist: String
//    init(name: String, artist: String) {
//        self.name = name
//        self.artist = artist
//    }
//}

struct TypeCastingExample {
    static func run() {
        let library: [MediaItem] = [
            Movie(name: "Casablanca", director: "Michael Curtiz"),
            Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
            Movie(name: "Citizen Kane", director: "Orson Welles"),
            Song(name: "The One And Only", artist: "Chesney Hawkes"),
            Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
        ]
        
        for item in library {
            guard item is MediaItem else { return }
            guard item is SomeAbstractItemInTheMiddle else { return }
            if item is Movie {
                print("movie")
            } else if item is Song {
                print("song")
            }
        }
        for item in library {
            print("item name: \(item.name)")
            if let movie = item as? Movie {
                print("director: \(movie.director)")
            } else if let song = item as? Song {
                print("author: \(song.artist)")
            }
        }
    }
}
