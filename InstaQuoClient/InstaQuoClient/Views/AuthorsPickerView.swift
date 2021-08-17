//
//  AuthorsPickerView.swift
//  InstaQuoClient
//
//  Created by Nataliia Getlin on 8/14/21.
//

import SwiftUI

struct AuthorsPickerView: View {
    @ObservedObject var authorListViewModel = AuthorListViewModel()

    @State private var frameHeight: CGFloat = 400
    
    @Binding var pickerField: String
    @Binding var presentPicker: Bool
    
    init(pickerField: Binding<String>, presentPicker: Binding<Bool>) {
        self._pickerField = pickerField
        self._presentPicker = presentPicker
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
                    
//                    Stretch goal: add new author from picker view
//                    Text("Add new author")
//                        .padding(.leading, 20)
//                        .padding(.top, 20)
//                        .foregroundColor(.blue)

                    List(authorListViewModel.authors) {author in
                            Button(action: {
                                pickerField = author.name
                                withAnimation {
                                    presentPicker = false
                                }
                            }, label: {
                                Text(author.name)
                            })
                        //}
                    }.onAppear() {
                        self.authorListViewModel.getAuthors()
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

struct CustomPickerViewTest_Previews: PreviewProvider {
//    static let authors = ["Barbara Oakley", "Dan Ariely", "James Clear", "Matthew Walker", "Lisa Feldman Barrett", "David Baldacci", "Someone"].sorted()
    
    static var previews: some View {
        AuthorsPickerView(pickerField: .constant(""), presentPicker: .constant(true))
    }
}
