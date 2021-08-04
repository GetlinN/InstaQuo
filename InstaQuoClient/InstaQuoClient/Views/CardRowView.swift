//
//  CardRowView.swift
//  InstaQuoClient
//
//  Created by Nataliia Getlin on 7/30/21.
//

import SwiftUI

struct CardRowView: View {
    
    var card: CardViewModel
    
    var body: some View {
        
        RoundedRectangle(cornerRadius: 6)
            .fill(Color.purple)
            .frame(height: 120)
            .overlay(
                HStack {
        //            card.image
        //                .resizable()
        //                .frame(width: 50, height: 70)
        //                .border(Color.white)
        //                .clipped()
        ////                .aspectRatio(contentMode: .fill)
        ////                .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        ////                .scaledToFit()
                    Text(card.quoteCard.quote)
                        .padding()
                        .lineLimit(3)
                    
                    Spacer()
                    
                    if card.quoteCard.isFavorite {
                        Image(systemName: "star.fill")
                            .foregroundColor(.pink)
                    }
                }
            )
    }
}

struct CardRowView_Previews: PreviewProvider {
    static let fakeCards = [Card(quote: "Test quote", bookTitle: "Book title", bookAuthor: "Author", personalNote: "Note"), Card(quote: "Test quote", bookTitle: "Book title", bookAuthor: "Author", personalNote: "Note")]
    static var cardViewModels = [CardViewModel(quoteCard: fakeCards[0]), CardViewModel(quoteCard: fakeCards[1])]

    static var previews: some View {

        Group {
            CardRowView(card: cardViewModels[0])
            CardRowView(card: cardViewModels[1])

//            CardRowView(card: quoteCards[2])
//            CardRowView(card: quoteCards[3])
//            CardRowView(card: quoteCards[4])
//            CardRowView(card: quoteCards[5])
        }
//        approximates a row in a list.
        .previewLayout(.fixed(width: 300, height: 80))
    }
}
