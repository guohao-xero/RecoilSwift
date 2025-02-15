import Foundation

public final class Atom<T: Equatable> {
    public let key: String
    private var get: () throws -> T
    
    public init(key: String = "Atom-\(UUID())", _ value: T) {
        self.key = key
        get = { value }
    }
}

extension Atom: RecoilValue {
    public func data(from loadable: Loadable) -> T {
        let loadBox = loadable as! LoadBox<T, Never>
        
        if let data = loadBox.data {
            return data
        }
        
        loadBox.load()
        return loadBox.data!
    }
    
    public func makeLoadable() -> LoadBox<T, Never> {
        let loader = SynchronousLoader(get)
        return LoadBox(loader: loader)
    }
}

extension Atom: RecoilWriteable {
    public func update(with value: T) {
        self.get = { value }
        Store.shared.update(value: self)
    }
}
