//
//  CardModel.swift
//  InstaQuoClient
//
//  Created by Nataliia Getlin on 7/30/21.
//

//import Foundation
//import SwiftUI
//import FirebaseFirestore
import FirebaseFirestoreSwift


struct Card: Codable, Identifiable {
    @DocumentID var id: String?
    var quote: String
    var bookTitle: String
    var bookAuthor: String
    var personalNote: String
    var isFavorite: Bool = false
}

//BEFORE
//struct Card: Hashable, Codable, Identifiable {
//    var id: Int
//    var quote: String
//    var bookTitle: String
//    var bookAuthor: String
//    var personalNote: String
//    var isFavorite: Bool
//
//
////    var dateCreated: Date
////    var dateEdited: Date
////    var bookPage: Int
////    var tags: [String]
////    var userID: Int
//
//
//    private var bookCoverImageFileName: String
//    var image: Image {
//        Image(bookCoverImageFileName)
//    }
//
//}
