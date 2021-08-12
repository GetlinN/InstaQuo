//
//  AuthorRepository.swift
//  InstaQuoClient
//
//  Created by Nataliia Getlin on 8/11/21.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

final class AuthorRepository: ObservableObject {
    private let path = "authors"
    private let db = Firestore.firestore()
    @Published var authors: [Author] = []
    
    init() {
        get()
    }
    
    func get() {
        db.collection(path).addSnapshotListener {(snapshot, error) in
            if let error = error {
                print(error)
                return
            }
            self.authors = snapshot?.documents.compactMap {
                try? $0.data(as: Author.self)
            } ?? []
        }
    }
    
    func add(_ author: Author) {
        do {
            _ = try db.collection(path).addDocument(from: author)
            
        } catch {
            fatalError("Adding author failed")
        }
    }
    
    func update(_ author: Author) {
        guard let documentID = author.id else { return }
        do {
            try db.collection(path).document(documentID).setData(from: author)
        } catch {
            fatalError("Updating author failed")
        }
    }
    
    func remove(_ author: Author) {
        guard let documentID = author.id else { return }
        db.collection(path).document(documentID).delete { error in
            if error != nil {
                print("Unable to remove the author with ID \(documentID)")
            }
        }
    }
    
    //handle create new author with book or
    //updating existing one
    func processAuthorRequest(authorName: String, bookTitle: String) {
        processAuthorRequestInternally(authorName: authorName, bookTitle: bookTitle)
    }
    
    private func processAuthorRequestInternally(authorName: String, bookTitle: String) {
        var existingAuthor: Author?
        db.collection(path).whereField("name", isEqualTo: authorName).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                //we assume that we have only one document
                for author in querySnapshot!.documents {
                    //take the first one. in theory there should not be more than one
                    existingAuthor = try? author.data(as: Author.self)
                    break
                }
                let book = Book(title: bookTitle)
                if (existingAuthor == nil) {
                    self.add(Author(name: authorName, books: [book]))
                } else {
                    var authorBooks = existingAuthor!.books
                    let authorBooksTitles = existingAuthor!.books.map{$0.title}
                    if (!authorBooksTitles.contains(bookTitle)) {
                        authorBooks.insert(book)
                    }
                    existingAuthor!.books = authorBooks
                    self.update(existingAuthor!)
                }
            }
        }
    }
}
