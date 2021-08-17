//
//  CardListView.swift
//  InstaQuoClient
//
//  Created by Nataliia Getlin on 7/30/21.
//

import SwiftUI
import FirebaseFirestore


struct CardListView: View {
    
    @ObservedObject var cardListViewModel: CardListViewModel
    
//    @EnvironmentObject var modelData: ModelData

    @State private var showingActionSheet: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State private var imageSelected: UIImage?
    @State private var showFavoritesOnly = false
    @State private var showingForm = false // for user to add new question
    
    @State private var showingScanningView = false
    @State private var recognizedText = ""


//    let tabBarImageNames = ["house", "plus.app.fill", "person"]
    
    var body: some View {
            NavigationView {
                VStack {
                    Toggle(isOn: $showFavoritesOnly) { Text("Favorites only") }.padding()
                    
                    List {
                        ForEach(cardListViewModel.cardViewModels.filter {
                            $0.quoteCard.isFavorite || !showFavoritesOnly}) { cardVM in
                            NavigationLink(destination: CardDetailView(card: cardVM, didUpdateCard: {(card) in
                                    cardListViewModel.update(card)
                                    }, didDeleteCard: {(card) in
                                        cardListViewModel.remove(card)
                                    }, didAddCard: {_ in print("done")})) {
                                CardRowView(card: cardVM)
                            }
                        }.onDelete(perform: delete)
                    }
                    
//                    for testing/debugging
                    Divider()
                    
//                    Text("# of records in db: \(cardListViewModel.cardViewModels.count)").padding(10)
                    
//                    for testing
//                    ScrollView {
//                        Text(recognizedText).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/).padding(20)
//                    }
                    
//                    Image(uiImage: imageSelected ?? UIImage(named: "why_we_sleep")!)
//                        .resizable()
//                        .frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).scaledToFill()
                    
                    HStack {
                        
//                        Scan Button
                        Spacer()
                        Button(action: {showingForm = true}) {
                            Image(systemName: "pencil.tip.crop.circle.badge.plus")
                                .font(.system(size: 35, weight: .regular))
                        }.padding()
                        .sheet(isPresented: $showingForm, content: {
                            CardDetailView(
                                card: CardViewModel(quoteCard: Card(quote: recognizedText, bookTitle: "", bookAuthor: "", personalNote: "")),
                                didUpdateCard: {_ in print("done")},
                                didDeleteCard: {_ in print("done")},
                                didAddCard: {(card) in
                                cardListViewModel.add(card)
                                showingForm = false},
                                isEditModeOn: true,
                                isNewCard: true)
                        })
//                        Scan Button

                        
                        Spacer()
                        Button(action: {
                            self.showingActionSheet = true
                        }) {
                            Image(systemName: "person.circle.fill")
                                .font(.system(size: 35, weight: .regular))
                        }.padding()
                        
                        Spacer()
                        Button(action: {showingScanningView = true}) {
                            Image(systemName: "camera.viewfinder")
                                .font(.system(size: 40, weight: .regular))
                        }.padding()
                        .sheet(isPresented: $showingScanningView, content: {
                            CardDetailView(
                                card: CardViewModel(quoteCard: Card(quote: recognizedText, bookTitle: "", bookAuthor: "", personalNote: "")),
                                didUpdateCard: {_ in print("done")},
                                didDeleteCard: {_ in print("done")},
                                didAddCard: {(card) in
                                cardListViewModel.add(card)
                                showingScanningView = false},
                                isEditModeOn: true,
                                isNewCard: true,
                                isScanModeOn: true)
                        })
                        Spacer()
                    }
                }
                .navigationTitle("Quotes")
            }
//            .sheet(isPresented: $showImagePicker, content: {
//
//                ImagePickerView(imageSelected: $imageSelected, isShown: $showImagePicker, sourceType: self.sourceType)
//                // Placeholder for ImagePicker()
////                Text("Something awsome should be here!")
//            })
//            Spacer()
           
    }
    
    private func delete(at offsets: IndexSet) {
        offsets.map {cardListViewModel.cardViewModels[$0].quoteCard}.forEach(cardListViewModel.remove)
    }
   
}

struct CardListView_Previews: PreviewProvider {
    static var previews: some View {
        
        CardListView(cardListViewModel: CardListViewModel())
        
//        ForEach(["iPhone SE (2nd generation)", "iPhone XS Max"], id: \.self) { deviceName in
//            CardListView()
//                .previewDevice(PreviewDevice(rawValue: deviceName))
//                .previewDisplayName(deviceName)
//        }
    }
}
