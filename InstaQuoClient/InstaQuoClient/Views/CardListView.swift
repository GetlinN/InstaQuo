//
//  CardListView.swift
//  InstaQuoClient
//
//  Created by Nataliia Getlin on 7/30/21.
//

import SwiftUI

struct CardListView: View {
    
    let tabBarImageNames = ["house", "plus.app.fill", "person"]
    
    var body: some View {
        VStack {
            NavigationView {
                List(quoteCards) { card in
                    NavigationLink(destination: CardDetailView(card: card)) {
                        CardRowView(card: card)
                    }
                    .navigationTitle("Quotes")
                }
            }
            Spacer()
            HStack {
                ForEach(0..<3) { num in
                    Spacer()
                    Image(systemName: tabBarImageNames[num])
                        .font(.system(size: 35, weight: .bold))
                    Spacer()
                }
            }
        }
    }
}

struct CardListView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE (2nd generation)", "iPhone XS Max"], id: \.self) { deviceName in
            CardListView()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
