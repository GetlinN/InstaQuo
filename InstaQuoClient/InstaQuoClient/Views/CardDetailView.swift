//
//  CardDetailView.swift
//  InstaQuoClient
//
//  Created by Nataliia Getlin on 7/30/21.
//

import SwiftUI

struct CardDetailView: View {
    
    @ObservedObject var card: CardViewModel
    
    @State private var isEditing = false
    
    let fontSize = CGFloat(20)
    
//   TODO: is it possible to make it optional
    var didUpdateCard: (_ card: Card) -> Void
    var didDeleteCard: (_ card: Card) -> Void
    var didAddCard: (_ card: Card) -> Void
    
    @Environment(\.presentationMode) var presentationMode

    
    var body: some View {
        
        ScrollView {
            VStack {
                Text("State: \(isEditing.description)")
               
                VStack(alignment: .leading) {
                    Label("Quote", systemImage: "1.circle")
                        .foregroundColor(Color.gray)
                    
                    TextEditor(text: $card.quoteCard.quote)
                        .disabled(!isEditing)
                        .frame(minWidth: 0, maxWidth: 350, minHeight: 0, maxHeight: 1500, alignment: .leading)
                        .lineLimit(10)
                        .font(.custom("HelveticaNeue", size: fontSize))
    //                    .lineSpacing(5)
                }.frame(height: 200)
                
                Divider().padding()
                VStack(alignment: .leading) {
                    Label("Book Title", systemImage: "2.circle")
                        .foregroundColor(Color.gray)
                    TextEditor(text: $card.quoteCard.bookTitle)
                        .disabled(!isEditing)
                        .frame(minWidth: 0, maxWidth: 350, minHeight: 0, maxHeight: 80, alignment: .leading)
                        .font(.custom("HelveticaNeue", size: fontSize))
    //                    .lineSpacing(5)
                }.frame(height: 90)
                
                Divider().padding()
                VStack(alignment: .leading) {
                    Label("Author", systemImage: "3.circle")
                        .foregroundColor(Color.gray)
                    TextEditor(text: $card.quoteCard.bookAuthor)
                        .disabled(!isEditing)
                        .frame(minWidth: 0, maxWidth: 350, minHeight: 0, maxHeight: 50, alignment: .leading)
                        .font(.custom("HelveticaNeue", size: fontSize))
    //                    .lineSpacing(5)
                }
                Divider().padding()
                VStack(alignment: .leading) {
                    Label("Personal Note", systemImage: "4.circle")
                        .foregroundColor(Color.gray)
                    TextEditor(text: $card.quoteCard.personalNote)
                        .disabled(!isEditing)
                        .frame(minWidth: 0, maxWidth: 350, minHeight: 0, maxHeight: 1500)
                        .lineLimit(10)
                        .font(.custom("HelveticaNeue", size: fontSize))
    //                    .lineSpacing(5)
                }.frame(height: 300)
                
                VStack(alignment: .leading) {
                    Toggle(isOn: $card.quoteCard.isFavorite, label: {
                        Text("Favorite")
                            .font(.custom("HelveticaNeue", size: fontSize))
                    })
                    .disabled(!isEditing)
                    .padding(.init(top: 15, leading: 25, bottom: 15, trailing: 25))
                }
                
                
            }
            
//            TODO
//            FavouriteFeatureView(isSet: $cardListViewModel.cardViewModels[cardIndex].quoteCard.isFavorite)
            
//            FavouriteFeatureView(isSet: $modelData.quoteCards[cardIndex].isFavorite)
            

            HStack {
                Button(action: {
                    if isEditing {
                        didUpdateCard(card.quoteCard)
                        isEditing.toggle()
                    } else {
                        isEditing.toggle()
                    }
                    
                }, label: {
                    Text(isEditing ? "Done editing": "Edit card")
                })
                
                if isEditing {
                    Button(action: {
                        didDeleteCard(card.quoteCard)
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Remove card")
                    }).padding()
                }
            }
            
        }
        .navigationTitle("Selected Quote")
        .navigationBarTitleDisplayMode(.inline)
//        .fixedSize(horizontal: false, vertical: true)
//        .toolbar { EditButton() }
    }
}

struct CardDetailView_Previews: PreviewProvider {

//    static let modelData = ModelData()
    static let fakeCard = Card(quote: "Humans are not sleeping the way nature intended. The number of sleep bouts, the duration of sleep, and when sleep occurs has all been comprehensively distorted by modernity.", bookTitle: "Why We Sleep: Unlocking the Power of Sleep and Dreams", bookAuthor: "Matthew Walker", personalNote: "Matthew Walker is a British scientist and professor of neuroscience and psychology at the University of California, Berkeley. His research focuses on the impact of sleep on human health and disease. Previously, he was a professor of psychiatry at Harvard Medical School.", isFavorite: true)

    static var previews: some View {
        CardDetailView(card: CardViewModel(quoteCard: fakeCard), didUpdateCard: {_ in print("done")}, didDeleteCard: {_ in print("done")}, didAddCard: {_ in print("done")})
//        CardDetailView(card: ModelData().quoteCards[0])
//            .environmentObject(modelData)
    }
}

