import Foundation

@propertyWrapper struct Capitalized: Hashable {
    var wrappedValue: String {
        didSet { wrappedValue = wrappedValue.capitalized }
    }
    init(wrappedValue: String) {
        self.wrappedValue = wrappedValue.capitalized
    }
}

@propertyWrapper struct UserDefaultsBackend<T> {
    
    enum Key {
        /// Key for storing memo game best results for given size
        case memo(Int)
        /// Default key for initial state, storage temporary things ...
        case storage
        
        var value: String {
            switch self {
                case .memo(let size):
                    return "memoBS\(size)"
                case .storage:
                    return "storage"
            }
        }
    }
    
    var key: Key = .storage
    var storage: UserDefaults = .standard

    var wrappedValue: T? {
        get { storage.value(forKey: key.value) as? T }
        set { storage.setValue(newValue, forKey: key.value) }
    }
}

/* TODO:
 simple:
 
 @State
 @Binding
 
 @AppStorage
 @SceneStorage
 
 @Published
 
 complex:
 
 @StateObject
 @ObservedObject
 
 @EnvironmentObject
 */
