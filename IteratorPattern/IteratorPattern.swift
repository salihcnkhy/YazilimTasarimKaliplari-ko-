
class WordsCollection {
    
    fileprivate lazy var items = [String]()
    
    func append(_ item: String) {
        self.items.append(item)
    }
}

extension WordsCollection: Sequence {
    
    func makeIterator() -> WordsIterator {
        return WordsIterator(self)
    }
}

class WordsIterator: IteratorProtocol {
    
    private let collection: WordsCollection
    private var index = 0
    init(_ collection: WordsCollection) {
        self.collection = collection
    }
    
    func next() -> String? {
        defer { index += 1 }
        return getCurrentElement()
    }
    func getCurrentElement() -> String?{
        return index < collection.items.count ? collection.items[index] : nil
    }
}




let words = WordsCollection()
words.append("First")
words.append("Second")
words.append("Third")
let iterator = words.makeIterator()
while iterator.getCurrentElement() != nil {
    print(iterator.next() ?? "nil")
}
