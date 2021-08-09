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
    @State private var recognizedText = "Recognized text will be displayed here."


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
                    
                    Divider()
                    Text("# of records in db: \(cardListViewModel.cardViewModels.count)").padding(10)
                    
//                    remove later
                    ScrollView {
                        
                        
                        // begin : this is to remove later, used for feature develompent and testing
                        
                        Divider()
                        Text(recognizedText).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/).padding(20)
                    }
                    
                    
//                    Image(uiImage: imageSelected ?? UIImage(named: "why_we_sleep")!)
//                        .resizable()
//                        .frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).scaledToFill()
                    
//                    tab bars
                    HStack {
                        
//                        Temporarily Scan Button
                        Spacer()
                        Button(action: {showingScanningView = true}) {
                            Image(systemName: "scanner")
                                .font(.system(size: 35, weight: .regular))
                        }.padding()
                        .sheet(isPresented: $showingScanningView, content: {
                            ScanDocumentView(recognizedText: self.$recognizedText)
                            
//                                    CardDetailView(
//                                       card: CardViewModel(quoteCard: Card(quote: recognizedText, bookTitle: "", bookAuthor: "", personalNote: "")),
//                                          didUpdateCard: {_ in print("done")},
//                                          didDeleteCard: {_ in print("done")},
//                                          didAddCard: {(card) in
//                                           cardListViewModel.add(card)
//                                           showingForm = false}, isEditModeOn: true, isNewCard: true)
                            
                        })
//                        Temporarily Scan Button

                        
                        Spacer()
                        
                        Button(action: {
                            self.showingActionSheet = true
                        }) {
                            Image(systemName: "plus.app.fill")
                                .font(.system(size: 35, weight: .regular))
                        }.padding()
                        .actionSheet(isPresented: $showingActionSheet, content: {
                            
                            ActionSheet(title: Text("Select Photo"),message: Text("Choose"), buttons: [.default(Text("Photo Library")) {
                                self.showImagePicker = true
                                self.sourceType = .photoLibrary
                            },
                            .default(Text("Camera")) {
                                self.showImagePicker = true
                                self.sourceType = .camera
                            },
                            .default(Text("Scan")) {
                                self.showImagePicker = true
                                self.sourceType = .camera
                            },
                            .cancel()
                            ])
                        })
                        
                        Spacer()
//                         This Button create new empty form
                        Button(action: {showingForm = true}) {
                            Image(systemName: "pencil")
                                .font(.system(size: 35, weight: .regular))
                        }.padding()
                        .sheet(isPresented: $showingForm, content: {
                            
                            CardDetailView(
                            card: CardViewModel(quoteCard: Card(quote: "", bookTitle: "", bookAuthor: "", personalNote: "")),
                               didUpdateCard: {_ in print("done")},
                               didDeleteCard: {_ in print("done")},
                               didAddCard: {(card) in
                                cardListViewModel.add(card)
                                showingForm = false}, isEditModeOn: true, isNewCard: true)
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
