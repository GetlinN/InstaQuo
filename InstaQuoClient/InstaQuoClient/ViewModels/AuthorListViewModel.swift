//
//  AuthorViewModel.swift
//  InstaQuoClient
//
//  Created by Nataliia Getlin on 8/11/21.
//

import Combine
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift


final class AuthorListViewModel: ObservableObject {
    @Published var authorRepository = AuthorRepository()
    @Published var authorViewModels: [AuthorViewModel] = []
    private var cancellabels: Set<AnyCancellable> = []
    
    @Published var authors: [Author] = []
    
    
    private let path = "authors"
    private let db = Firestore.firestore()
    
    func getAuthors() {
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
    
//    func get() {
//        authorRepository.$authors
//            .map { author in
//                author.map(AuthorViewModel.init)
//            }
//            .assign(to: \.authorViewModels, on: self)
//            .store(in: &cancellabels)
//    }
    
//    func add(_ author: Author) {
//        authorRepository.add(author)
//    }
//
//    func remove(_ author: Author) {
//        authorRepository.remove(author)
//    }
//
//    func update(_ author: Author) {
//        authorRepository.update(author)
//    }
}
