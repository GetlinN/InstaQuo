//
//  Book.swift
//  InstaQuoClient
//
//  Created by Nataliia Getlin on 8/11/21.
//

import FirebaseFirestoreSwift


struct Book: Codable, Identifiable, Hashable {
    @DocumentID var id: String?
    var title: String
}
