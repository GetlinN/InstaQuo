//
//  CardRepository.swift
//  InstaQuoClient
//
//  Created by Nataliia Getlin on 8/3/21.
//

import FirebaseFirestore
//import FirebaseFirestoreSwift
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
        db.collection(path).addSnapshotListener {(snapshot, error) in
            if let error = error {
                print(error)
                return
            }
            self.quoteCards = snapshot?.documents.compactMap {
                try? $0.data(as: Card.self)
            } ?? []
        }
    }

}
