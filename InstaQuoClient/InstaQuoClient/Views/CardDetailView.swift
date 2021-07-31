//
//  CardDetailView.swift
//  InstaQuoClient
//
//  Created by Nataliia Getlin on 7/30/21.
//

import SwiftUI

struct CardDetailView: View {
    
//    @State private var fullText: String = "This is some editable text... This is some editable text... This is some editable text... This is some editable text... This is some editable text..."
//    @State private var bookTitle: String = "Some book title"
//    @State private var bookAuthor: String = "David Smith"
//    @State private var personalNote: String = "This is a place for personal notes."

    @State var card: Card

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Label("Quote", systemImage: "1.circle")
                    .foregroundColor(Color.gray)
                TextEditor(text: $card.quote)
                    .frame(width: 250, height: 250, alignment: .leading)
                    .lineLimit(10)
                    .font(.custom("HelveticaNeue", size: 13))
                    .lineSpacing(5)
            }
            Divider()
            VStack(alignment: .leading) {
                Label("Book Title", systemImage: "2.circle")
                    .foregroundColor(Color.gray)
                TextEditor(text: $card.bookTitle)
                    .frame(width: 250, height: 30, alignment: .leading)
                    .lineLimit(10)
                    .font(.custom("HelveticaNeue", size: 13))
                    .lineSpacing(5)
            }
            Divider()
            VStack(alignment: .leading) {
                Label("Author", systemImage: "3.circle")
                    .foregroundColor(Color.gray)
                TextEditor(text: $card.bookAuthor)
                    .frame(width: 250, height: 30, alignment: .leading)
                    .lineLimit(10)
                    .font(.custom("HelveticaNeue", size: 13))
                    .lineSpacing(5)
            }
            Divider()
            VStack(alignment: .leading) {
                Label("Personal Note", systemImage: "4.circle")
                    .foregroundColor(Color.gray)
                TextEditor(text: $card.personalNote)
                    .frame(width: 250, height: 250, alignment: .leading)
                    .lineLimit(10)
                    .font(.custom("HelveticaNeue", size: 13))
                    .lineSpacing(5)
            }
            
//            EditButton()
        }
        .navigationTitle("Selected Quote")
        .navigationBarTitleDisplayMode(.inline)
//        .fixedSize(horizontal: false, vertical: true)
//        .toolbar { EditButton() }
    }
}

struct CardDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CardDetailView(card: quoteCards[0])
    }
}
