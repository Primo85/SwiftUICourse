
extension String {
    init?(_ optInt: Int?) {
        if let int = optInt {
            self = String(int)
        } else {
            return nil
        }
    }
}

extension Array {
    subscript(safe index: Int?) -> Element? {
        if let i = index, i < self.count {
            return self[i]
        } else {
            return nil
        }
    }
}
