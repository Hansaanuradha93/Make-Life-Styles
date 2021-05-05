import Foundation

class Bindable<T> {
    
    // MARK: Properties
    var value: T? {
        didSet { observer?(value) }
    }
    
    
    private var observer: ((T?) -> ())?
}

// MARK: - Methods
extension Bindable {
    
    func bind(observer: @escaping (T?) -> ()) {
        self.observer = observer
    }
}
