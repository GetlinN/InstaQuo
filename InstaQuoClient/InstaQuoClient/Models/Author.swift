//
//  Author.swift
//  InstaQuoClient
//
//  Created by Nataliia Getlin on 8/11/21.
//

import FirebaseFirestoreSwift


struct Author: Codable, Identifiable {
    @DocumentID var id: String?
    var name: String
    var books: Set<Book>
}
