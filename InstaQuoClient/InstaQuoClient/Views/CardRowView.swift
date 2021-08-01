//
//  CardRowView.swift
//  InstaQuoClient
//
//  Created by Nataliia Getlin on 7/30/21.
//

import SwiftUI

struct CardRowView: View {
    
    var card: Card
    
    var body: some View {
        HStack {
            card.image
                .resizable()
                .frame(width: 50, height: 70)
                .border(Color.white)
                .clipped()
//                .aspectRatio(contentMode: .fill)
//                .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                .scaledToFit()
            Text(card.quote)
                .lineLimit(3)
            
            Spacer()
            
            if card.isFavorite {
                Image(systemName: "star.fill")
                    .foregroundColor(.pink)
            }
            
        }
    }
}

struct CardRowView_Previews: PreviewProvider {
    static var previews: some View {
                
        Group {
            CardRowView(card: quoteCards[0])
            CardRowView(card: quoteCards[1])
            CardRowView(card: quoteCards[2])
            CardRowView(card: quoteCards[3])
            CardRowView(card: quoteCards[4])
            CardRowView(card: quoteCards[5])
        }
//        approximates a row in a list.
        .previewLayout(.fixed(width: 300, height: 80))
    }
}
