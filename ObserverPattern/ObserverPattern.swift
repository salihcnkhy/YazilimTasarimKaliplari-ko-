protocol ObservableProtocol : class {
    var observers : [ObserverProtocol] { get set }
    
    func addObserver(_ observer: ObserverProtocol)
    func removeObserver(_ observer: ObserverProtocol)
    func notifyObservers(_ observers: [ObserverProtocol])
}

protocol ObserverProtocol {
    
    var id : UUID { get set }
    func onValueChanged(_ value: Any?)
}

class Observable<T> : ObservableProtocol {
    
    var value : T {
        didSet {
            self.notifyObservers(self.observers)
        }
    }
    
    var observers : [ObserverProtocol] = []
    
    init(value: T) {
        self.value = value
    }
    
    func addObserver(_ observer: ObserverProtocol) {
        guard self.observers.contains(where: { $0.id == observer.id }) == false else {
            return
        }
        self.observers.append(observer)
    }
    
    func removeObserver(_ observer: ObserverProtocol) {
        guard let index = self.observers.firstIndex(where: { $0.id == observer.id }) else {
            return
        }
        self.observers.remove(at: index)
        
    }
    
    func notifyObservers(_ observers: [ObserverProtocol]) {
        observers.forEach({ $0.onValueChanged(value)})
    }
    
    deinit {
        observers.removeAll()
    }
}
class List {
    var numberOfItems : Observable<Int>
    
    init(numberOfItems: Int) {
        self.numberOfItems = Observable(value: numberOfItems)
    }
    
    func addItemToList() {
        numberOfItems.value = numberOfItems.value + 1
    }
}

class ListViewModel : ObserverProtocol {
    
    var id = UUID()
    func onValueChanged(_ value: Any?) {
        print("new listItem \(value)")
    }
}

let userList = List(numberOfItems: 0)
let listViewModel = ListViewModel()
userList.numberOfItems.addObserver(listViewModel)

userList.addItemToList()
