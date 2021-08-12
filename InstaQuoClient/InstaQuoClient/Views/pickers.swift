//
//  pickers.swift
//  InstaQuoClient
//
//  Created by Nataliia Getlin on 8/10/21.
//

import SwiftUI
//import UIKit


struct pickers: View {
    
    @State private var authorID = 0
    var authors = ["Barbara Oakley", "Dan Ariely", "James Clear", "Matthew Walker", "Lisa Feldman Barrett", "David Baldacci"]
    @State var searchText: String = ""

    var body: some View {
//        Text("Selection")

        NavigationView {
            Form {
                Section {
                    Picker(selection: $authorID, label: Text("Author")) {
                        TextField("Search", text: $searchText)
                            .padding(7)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                        
                        
                        
//                        ForEach(authors.filter {
//                                    searchText.isEmpty || $0.localizedStandardContains(searchText)},
//                                {content: Text(self.authors[$0]).bold().tag($0)}
                        ForEach(0 ..< authors.count) {
                            Text(self.authors[$0]).bold().tag($0)
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Author"))
            
        }


    }
}

struct pickers_Previews: PreviewProvider {
    static var previews: some View {
        pickers()
    }
}
