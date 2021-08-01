//
//  CardListView.swift
//  InstaQuoClient
//
//  Created by Nataliia Getlin on 7/30/21.
//

import SwiftUI

struct CardListView: View {
    @State private var showingActionSheet: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State private var imageSelected: UIImage?
    @State private var showFavoritesOnly = false
    
    var filteredQuoteCards: [Card] {
            quoteCards.filter { card in
                (!showFavoritesOnly || card.isFavorite)
            }
        }

    
//    let tabBarImageNames = ["house", "plus.app.fill", "person"]
    
    var body: some View {
            NavigationView {
                VStack {
                    
                    List {
                        
                        Toggle(isOn: $showFavoritesOnly, label: {
                            Text("Favorites only")
                        })
                        
                        ForEach(filteredQuoteCards) { card in
                            NavigationLink(destination: CardDetailView(card: card)) {
                                CardRowView(card: card)
                            }
                        }
                    }
                    
                    // begin : this is to remove later, used for feature develompent and testing
                    
                    Divider()
                    Text("Selected Image is displayed here").foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    
                    
                    Image(uiImage: imageSelected ?? UIImage(named: "why_we_sleep")!)
                        .resizable()
                        .frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).scaledToFill()
//                        .padding()
                    // end
                    
//                    tab bars
                    HStack {
                        Spacer()
                        Button(action: {}) {
                            Image(systemName: "house")
                                .font(.system(size: 35, weight: .regular))
                        }.padding()
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
                        Button(action: {}) {
                            Image(systemName: "person")
                                .font(.system(size: 35, weight: .regular))
                        }.padding()
                        Spacer()

                        
//                        ForEach(0..<3) { num in
//                            Spacer()
//                            Image(systemName: tabBarImageNames[num])
//                                .font(.system(size: 30, weight: .regular))
//                            Spacer()
//                        }
                    }
                
                }
                .navigationTitle("Quotes")
            }.sheet(isPresented: $showImagePicker, content: {
                
                ImagePickerView(imageSelected: $imageSelected, isShown: $showImagePicker, sourceType: self.sourceType)
                // Placeholder for ImagePicker()
//                Text("Something awsome should be here!")
            })
//            Spacer()д
           
    }
    
    func delete(at offsets: IndexSet) {
           quoteCards.remove(atOffsets: offsets)
    }
}

struct CardListView_Previews: PreviewProvider {
    static var previews: some View {
        
        CardListView()
        
//        ForEach(["iPhone SE (2nd generation)", "iPhone XS Max"], id: \.self) { deviceName in
//            CardListView()
//                .previewDevice(PreviewDevice(rawValue: deviceName))
//                .previewDisplayName(deviceName)
//        }
    }
}
