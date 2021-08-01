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
    let fontSize = CGFloat(20)

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Label("Quote", systemImage: "1.circle")
                    .foregroundColor(Color.gray)
                TextEditor(text: $card.quote)
                    .frame(minWidth: 0, maxWidth: 350, minHeight: 0, maxHeight: 1500, alignment: .leading)
                    .lineLimit(10)
                    .font(.custom("HelveticaNeue", size: fontSize))
//                    .lineSpacing(5)
            }
            Divider()
            VStack(alignment: .leading) {
                Label("Book Title", systemImage: "2.circle")
                    .foregroundColor(Color.gray)
                TextEditor(text: $card.bookTitle)
                    .frame(width: 350, height: 30, alignment: .leading)
                    .lineLimit(10)
                    .font(.custom("HelveticaNeue", size: fontSize))
//                    .lineSpacing(5)
            }
            Divider()
            VStack(alignment: .leading) {
                Label("Author", systemImage: "3.circle")
                    .foregroundColor(Color.gray)
                TextEditor(text: $card.bookAuthor)
                    .frame(width: 350, height: 30, alignment: .leading)
                    .lineLimit(10)
                    .font(.custom("HelveticaNeue", size: fontSize))
//                    .lineSpacing(5)
            }
            Divider()
            VStack(alignment: .leading) {
                Label("Personal Note", systemImage: "4.circle")
                    .foregroundColor(Color.gray)
                TextEditor(text: $card.personalNote)
                    .frame(minWidth: 0, maxWidth: 350, minHeight: 0, maxHeight: 1500)
                    .lineLimit(10)
                    .font(.custom("HelveticaNeue", size: fontSize))
//                    .lineSpacing(5)
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
