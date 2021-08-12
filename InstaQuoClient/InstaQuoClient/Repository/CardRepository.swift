//
//  CardRepository.swift
//  InstaQuoClient
//
//  Created by Nataliia Getlin on 8/3/21.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

// final - preventing overrides
final class CardRepository: ObservableObject {
    private let path = "quoteCards"
    private let db = Firestore.firestore()
    @Published var quoteCards: [Card] = []
    
    init() {
        get()
    }
    
    func get() {
        db.collection(path).order(by: "dateCreated", descending: true).addSnapshotListener {(snapshot, error) in
            if let error = error {
                print(error)
                return
            }
            self.quoteCards = snapshot?.documents.compactMap {
                try? $0.data(as: Card.self)
            } ?? []
        }
    }
    
    func add(_ quoteCard: Card) {
        do {
            _ = try db.collection(path).addDocument(from: quoteCard)
        } catch {
            fatalError("Adding quote card failed")
        }
    }
    
    func update(_ quoteCard: Card) {
        guard let documentID = quoteCard.id else { return }
        do {
            try db.collection(path).document(documentID).setData(from: quoteCard)
        } catch {
            fatalError("Updating quote card failed")
        }
    }
    
    func remove(_ quoteCard: Card) {
        guard let documentID = quoteCard.id else { return }
        db.collection(path).document(documentID).delete { error in
            if error != nil {
                print("Unable to remove the card with ID \(documentID)")
            }
        }
    }

}
