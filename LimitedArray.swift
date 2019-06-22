struct LimitedArray<T> {
    private(set) var storage: [T] = [T]()
    public let maxSize: Int

    /// creates an empty array
    public init(maxSize: Int) {
        self.maxSize = maxSize
    }

    /// adds a new item to the array, if the array has reached its maximum capacity we remove the first one (the oldest value)
    public mutating func append(_ item: T) {
        if storage.count < maxSize {
            storage.append(item)
        } else {
            storage.removeFirst()
            storage.append(item)
        }
    }
}

// let's benefit all the awesome operations like map, flatMap, reduce, filter, etc
extension LimitedArray: MutableCollection {
    public var startIndex: Int { return storage.startIndex }
    public var endIndex: Int { return storage.endIndex }

    public subscript(_ index: Int) -> T {
        get { return storage[index] }
        set { storage[index] = newValue }
    }

    public func index(after i: Int) -> Int {
        return storage.index(after: i)
    }
}

extension LimitedArray: CustomStringConvertible {
    var description: String {
        return "[" + self.storage.map{"\"\($0)\""}.joined(separator: ", ") + "]"
    }
}
