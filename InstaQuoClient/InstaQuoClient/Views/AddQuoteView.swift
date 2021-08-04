//
//  AddQuoteView.swift
//  InstaQuoClient
//
//  Created by Nataliia Getlin on 8/3/21.
//

import SwiftUI

struct AddQuoteView: View {
    
    
    @State private var quote: String = ""
    @State private var bookTitle: String = ""
    @State private var bookAuthor: String = ""
    @State private var personalNote: String = ""
    @State private var isFavorite: Bool = false
    
    var didAddCard: (_ card: Card) -> Void

    
    var body: some View {
        
        NavigationView {
            VStack {
                Form {
                    TextField("Quote", text: $quote)
                    TextField("Book Title", text: $bookTitle)
                    TextField("Author", text: $bookAuthor)
                    TextField("Leave a note", text: $personalNote)
                    
                    
                    Toggle("Favorite", isOn: .init(
                        get: { isFavorite },
                        set: {
                            isFavorite = $0
                        }
                    ))
                                        
//                    Toggle(isOn: $isFavorite, label: {
//                        Text("Favorite")
//                    })
                }
                
                Button("New Quote") {
                    let card = Card(quote: quote, bookTitle: bookTitle, bookAuthor: bookAuthor, personalNote: personalNote, isFavorite: isFavorite)
                    didAddCard(card)
                }.disabled(quote.isEmpty || bookAuthor.isEmpty || bookTitle.isEmpty).padding()
            }.navigationTitle("Add quote")
            
        }
        
        
    }
}

struct AddQuoteView_Previews: PreviewProvider {
    static let fakeCard = Card(quote: "quote", bookTitle: "bookTitle", bookAuthor: "bookAuthor", personalNote: "personalNote")
    
    static var previews: some View {
        AddQuoteView(didAddCard: {_ in print("done")})
    }
}
