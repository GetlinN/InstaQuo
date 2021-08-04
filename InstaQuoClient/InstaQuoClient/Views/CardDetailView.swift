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
    
//    @EnvironmentObject var modelData: ModelData
    
    @ObservedObject var card: CardViewModel
//    @ObservedObject var cardListViewModel: CardListViewModel
//    @State var card: Card
    
    let fontSize = CGFloat(20)
    
//    var cardIndex: Int {
//        cardListViewModel.cardViewModels.firstIndex(where: {$0.quoteCard.id == card.id })
//    }
        
    var body: some View {
        ScrollView {
            
//            TODO
//            FavouriteFeatureView(isSet: $cardListViewModel.cardViewModels[cardIndex].quoteCard.isFavorite)
            
//            FavouriteFeatureView(isSet: $modelData.quoteCards[cardIndex].isFavorite)
            
            VStack(alignment: .leading) {
                Label("Quote", systemImage: "1.circle")
                    .foregroundColor(Color.gray)
                
                TextEditor(text: $card.quoteCard.quote)
                    .frame(minWidth: 0, maxWidth: 350, minHeight: 0, maxHeight: 1500, alignment: .leading)
                    .lineLimit(10)
                    .font(.custom("HelveticaNeue", size: fontSize))
//                    .lineSpacing(5)
            }
            Divider()
            VStack(alignment: .leading) {
                Label("Book Title", systemImage: "2.circle")
                    .foregroundColor(Color.gray)
                TextEditor(text: $card.quoteCard.bookTitle)
                    .frame(width: 350, height: 30, alignment: .leading)
                    .lineLimit(10)
                    .font(.custom("HelveticaNeue", size: fontSize))
//                    .lineSpacing(5)
            }
            Divider()
            VStack(alignment: .leading) {
                Label("Author", systemImage: "3.circle")
                    .foregroundColor(Color.gray)
                TextEditor(text: $card.quoteCard.bookAuthor)
                    .frame(width: 350, height: 30, alignment: .leading)
                    .lineLimit(10)
                    .font(.custom("HelveticaNeue", size: fontSize))
//                    .lineSpacing(5)
            }
            Divider()
            VStack(alignment: .leading) {
                Label("Personal Note", systemImage: "4.circle")
                    .foregroundColor(Color.gray)
                TextEditor(text: $card.quoteCard.personalNote)
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

//    static let modelData = ModelData()
    static let fakeCard = Card(quote: "Test quote", bookTitle: "Book title", bookAuthor: "Author", personalNote: "Note")

    static var previews: some View {
        CardDetailView(card: CardViewModel(quoteCard: fakeCard))
//        CardDetailView(card: ModelData().quoteCards[0])
//            .environmentObject(modelData)
    }
}

