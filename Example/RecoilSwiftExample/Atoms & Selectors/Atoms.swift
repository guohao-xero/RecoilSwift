import RecoilSwift

struct BookShop {}

// Atoms
extension BookShop {
    static let selectedQuarterState = Atom<Int?>(nil)
    static let allBookState = atom { [Book]() }
    static let selectedCategoryState = Atom<BookCategory?>(nil)
}

enum BookError: Error { }



