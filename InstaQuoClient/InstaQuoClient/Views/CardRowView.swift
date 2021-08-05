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
            .fill(getRandomColor())
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
                            .foregroundColor(Color.yellow)
                            .padding(15)
                    
                    }
                }
            )
    }
    
    func getRandomColor() -> Color {
        //Generate between 0 to 1
        let red:Double = Double.random(in: 0.5...1)
        let green:Double = Double.random(in: 0.5...1)
        let blue:Double = Double.random(in: 0.5...1)
        
        return Color(red:red, green: green, blue: blue)
    }
    
}

struct CardRowView_Previews: PreviewProvider {
    
    static let fakeCards = [Card(quote: "Test quote", bookTitle: "Book title", bookAuthor: "Author", personalNote: "Note"), Card(quote: "Test quote", bookTitle: "Book title", bookAuthor: "Author", personalNote: "Note"), Card(id: "Test3", quote: "You do not rise to the level of your goals. You fall to the level of your systems.", bookTitle: "Test3", bookAuthor: "Test3", personalNote: "Test3", isFavorite: true)]
    
    static var cardViewModels = [CardViewModel(quoteCard: fakeCards[0]), CardViewModel(quoteCard: fakeCards[1]),
        CardViewModel(quoteCard: fakeCards[2])
    ]

    static var previews: some View {

        Group {
            CardRowView(card: cardViewModels[0])
            CardRowView(card: cardViewModels[1])
            CardRowView(card: cardViewModels[2])

//            CardRowView(card: quoteCards[2])
//            CardRowView(card: quoteCards[3])
//            CardRowView(card: quoteCards[4])
//            CardRowView(card: quoteCards[5])
        }
//        approximates a row in a list.
        .previewLayout(.fixed(width: 300, height: 100))
    }
}
