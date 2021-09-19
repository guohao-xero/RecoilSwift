import SwiftUI
import RecoilSwift

struct ContentView: View {
    @RecoilValue(BookShop.currentBooksSel) var currentBooks: [Book]
    @RecoilValue(BookShop.fetchRemoteBookNames) var bookNames: [String]?
    @RecoilState(BookShop.allBookStore) var allBooks: [Book]
    @RecoilState(BookShop.selectedCategoryState) var selectedCategoryState: BookCategory?
    @RecoilState(BookShop.selectedQuarterState) var selectedQuarterState: Quarter?

    var body: some View {
        VStack {
            HStack {
                ForEach(Quarter.allCases, id: \.self) { quarter in
                    Button(quarter.rawValue) {
                        print(quarter.rawValue)
                        selectedQuarterState = quarter
                    }
                    .background(quarter == selectedQuarterState ? Color.yellow : Color.clear)
                    .padding()
                }
            }
            HStack {
                ForEach(BookCategory.allCases, id: \.self) { category in
                    Button(category.rawValue) {
                        print(category.rawValue)
                        selectedCategoryState = category
                    }
                    .background(category == selectedCategoryState ? Color.yellow : Color.clear)
                    .padding()
                }
            }

            ForEach(currentBooks, id: \.self) { itemView($0) }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .top)
        .contentShape(Rectangle())
        .onTapGesture {
            selectedCategoryState = nil
            selectedQuarterState = nil
        }
        .padding(.top, 88)
        .onAppear {
             allBooks = Mocks.ALL_BOOKS
         }
    }

    func itemView(_ book: Book) -> some View {
        HStack {
            Text(book.name)
            Spacer()
            Text(book.category.rawValue)
        }
        .padding()
        .background(Color.yellow)
    }
}

