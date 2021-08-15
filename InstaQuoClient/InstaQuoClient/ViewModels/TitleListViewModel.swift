//
//  TitleListViewModel.swift
//  InstaQuoClient
//
//  Created by Nataliia Getlin on 8/14/21.
//

import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift


final class TitleListViewModel: ObservableObject {
    private var cancellabels: Set<AnyCancellable> = []
    
    @Published var books: [Book] = []
    
    private let path = "authors"
    private let db = Firestore.firestore()
    
    func getBooks(authorName: String) {
        db.collection(path).whereField("name", isEqualTo: authorName).getDocuments() {(snapshot, error) in
            if let error = error {
                print(error)
                return
            }
            
            let authors = snapshot?.documents.compactMap {
                try? $0.data(as: Author.self)
            } ?? []
            
            authors.forEach{author in
                var bookId = 0
                author.books.forEach{book in
                    self.books.append(Book(id: String(bookId), title: book.title))
                    bookId += 1
                }
            }
        }
    }
    
}
