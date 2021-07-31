//
//  CardListView.swift
//  InstaQuoClient
//
//  Created by Nataliia Getlin on 7/30/21.
//

import SwiftUI

struct CardListView: View {
    var body: some View {
        List(quoteCards, id: \.id) { card in
            CardRowView(card: card)
        }
    }
}

struct CardListView_Previews: PreviewProvider {
    static var previews: some View {
        CardListView()
    }
}
