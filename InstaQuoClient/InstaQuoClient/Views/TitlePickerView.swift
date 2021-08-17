//
//  TitlePickerView.swift
//  InstaQuoClient
//
//  Created by Nataliia Getlin on 8/14/21.
//

import SwiftUI

struct TitlePickerView: View {
    @ObservedObject var titleListViewModel = TitleListViewModel()

    @State private var frameHeight: CGFloat = 400
    
    @Binding var pickerField: String
    @Binding var presentPicker: Bool
    @Binding var authorName: String
    
    init(pickerField: Binding<String>, presentPicker: Binding<Bool>,
         authorName: Binding<String>) {
        self._pickerField = pickerField
        self._presentPicker = presentPicker
        self._authorName = authorName //.constant("Test")
    }

    
    var body: some View {
        return ZStack {
            Color.black.opacity(0.4)
            VStack {
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Button(action: {
                            withAnimation {
                                presentPicker = false
                            }
                        }, label: {
                            Text("Cancel")
                        })
                        .padding(20)
                        Spacer()
                    }
                    .background(Color(UIColor.darkGray))
                    .foregroundColor(.white)
                   
//                    Stretch goal: add new title from picker view
//                    Text("Add new book title")
//                        .padding(.leading, 20)
//                        .padding(.top, 20)
//                        .foregroundColor(.blue)

                    List(titleListViewModel.books) {book in
                            Button(action: {
                                pickerField = book.title
                                withAnimation {
                                    presentPicker = false
                                }
                            }, label: {
                                Text(book.title)
                            })
                        //}
                    }.onAppear() {
                        self.titleListViewModel.getBooks(authorName: authorName)
                    }
                }
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)
                .frame(maxWidth: 400)
                .padding(.horizontal, 10)
                .frame(height: frameHeight)
                .padding(.top, 50)
                Spacer()
            }
        }
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        .onAppear {
            setHeight()
        }
    }
    
    fileprivate func setHeight () {
        withAnimation {
            frameHeight = 400
        }
    }
}

struct TitlePickerView_Previews: PreviewProvider {
//    static let authors = ["Barbara Oakley", "Dan Ariely", "James Clear", "Matthew Walker", "Lisa Feldman Barrett", "David Baldacci", "Someone"].sorted()
    
    static var previews: some View {
        TitlePickerView(pickerField: .constant(""), presentPicker: .constant(true), authorName: .constant("Author"))
    }
}
