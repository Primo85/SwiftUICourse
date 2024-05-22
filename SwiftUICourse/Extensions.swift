
postfix operator ++
postfix func ++(lhs: inout Int) { lhs += 1 }

extension String {
    init?(_ optInt: Int?) {
        if let int = optInt {
            self = String(int)
        } else {
            return nil
        }
    }
    
    static var winEmoji: String { ["😀", "😃", "😁", "😋", "😅"].randomElement()! }
    static var lossEmoji: String { ["😫", "☹️", "😟", "😨", "😥"].randomElement()! }
}

extension Array {
    subscript(safe index: Int?) -> Element? {
        if let i = index, 0 <= i, i < self.count {
            return self[i]
        } else {
            return nil
        }
    }
}
