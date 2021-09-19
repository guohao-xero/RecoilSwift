import Foundation
import Combine
import RecoilSwift

struct BookShop {}

// Atoms
extension BookShop {
    static let selectedQuarterState = Atom<Quarter?>(nil)
    static let allBookStore = atom { [Book]() }
    static let selectedCategoryState = Atom<BookCategory?>(nil)
}

// Selectors
extension BookShop {
    static let currentBooksSel = selector { get -> [Book] in
        var books = get(allBookStore)
        
        if let selectedQuarterState = get(selectedQuarterState) {
            books = books.filter { $0.publishDate == selectedQuarterState }
        }
        
        if let selectedCategoryState = get(selectedCategoryState) {
            books = books.filter { $0.category == selectedCategoryState }
        }
        
        return books
    }

    static let fetchRemoteBookNames = selector { get -> AnyPublisher<[String], Error> in
        func buildPromise(_ values: [String]) -> AnyPublisher<[String], Error> {
            Deferred {
                Future { promise in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        promise(.success(values))
                    }
                }
            }.eraseToAnyPublisher()
        }

        guard let category = get(selectedCategoryState) else {
            return buildPromise([])
        }

        return buildPromise(["1", "2"])
    }
}
