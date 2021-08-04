//
//  ContentView.swift
//  InstaQuoClient
//
//  Created by Nataliia Getlin on 7/30/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        CardListView(cardListViewModel: CardListViewModel())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//            .environmentObject(ModelData())
//        You apply this modifier so that views further down in the view hierarchy can read data objects passed down through the environment.
    }
}
