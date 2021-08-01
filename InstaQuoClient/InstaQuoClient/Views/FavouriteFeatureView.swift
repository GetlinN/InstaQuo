//
//  FavouriteFeatureView.swift
//  InstaQuoClient
//
//  Created by Nataliia Getlin on 7/31/21.
//

import SwiftUI

struct FavouriteFeatureView: View {
    
//    indicates the button’s current state, provides a constant value for the preview. changes made inside this view propagate back to the data source.
    @Binding var isSet: Bool
    
    var body: some View {
        
        
        VStack {
            Text("Mark as Favorite")
            
            Button(action: {isSet.toggle()}, label: {
                Image(systemName: isSet ? "star.fill" : "star")
                    .foregroundColor(isSet ? Color.pink : Color.gray )
            })
        }.padding()
        
    }
}

struct FavouriteFeatureView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteFeatureView(isSet: .constant(true))
    }
}
