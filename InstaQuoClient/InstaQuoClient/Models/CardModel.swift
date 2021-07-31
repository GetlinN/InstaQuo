//
//  CardModel.swift
//  InstaQuoClient
//
//  Created by Nataliia Getlin on 7/30/21.
//

import Foundation
import SwiftUI

struct Card: Hashable, Codable {
    var id: Int
    var quote: String
    var bookTitle: String
    var bookAuthor: String
    var personalNote: String
    
//    var dateCreated: Date
//    var dateEdited: Date
//    var isFavourite: Bool
//    var bookPage: Int
//    var tags: [String]
//    var userID: Int


    private var bookCoverImageFileName: String
    var image: Image {
        Image(bookCoverImageFileName)
    }

}
