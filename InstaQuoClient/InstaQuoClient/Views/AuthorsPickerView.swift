//
//  CustomPickerView.swift
//  InstaQuoClient
//
//  Created by Nataliia Getlin on 8/10/21.
//  Credits to Stewart Lynch: https://www.youtube.com/watch?v=ATgOV70YcI8
//

import SwiftUI

struct AuthorsPickerView: View {
    
    @ObservedObject var authorListViewModel: AuthorListViewModel

    @State private var filteredItems: [String] = []
    @State private var filterString: String = ""
    @State private var frameHeight: CGFloat = 400
    
    @Binding var pickerField: String
    @Binding var presentPicker: Bool
    
    private var items: [String]
    private var test: String
    
    init(authorListViewModel: AuthorListViewModel, pickerField: Binding<String>, presentPicker: Binding<Bool>) {
        self.authorListViewModel = authorListViewModel
        self._pickerField = pickerField
        self._presentPicker = presentPicker
        items = authorListViewModel.authorViewModels.map{$0.author.name}
        test = "Debug";
    }
    
    var body: some View {

        let filterBinding = Binding<String> (
            get: { filterString },
            set: {
                filterString = $0
                if filterString != "" {
                    filteredItems = items.filter{$0.lowercased().contains(filterString.lowercased())}
                } else {
                    filteredItems = items
                }
                setHeight()
            }
        )
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
                    Text("Add new author")
                        .padding(.leading, 20)
                        .padding(.top, 20)
                        .foregroundColor(.blue)
                    TextField("Filter by entering text", text: filterBinding).textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                   
                    List {
                        ForEach(filteredItems, id: \.self) {item in
                            Button(action: {
                                pickerField = item
                                withAnimation {
                                    presentPicker = false
                                }
                            }, label: {
                                Text(item)
                            })
                        }
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
            filteredItems = authorListViewModel.authorViewModels.map{$0.author.name}
            setHeight()
        }
    }
    
    fileprivate func setHeight () {
        withAnimation {
            if filteredItems.count >= 5 {
                frameHeight = 400
            } else if filteredItems.count == 0 {
                frameHeight = 130
            } else {
                frameHeight = CGFloat(filteredItems.count * 45 + 130)
            }
        }
    }
}

struct CustomPickerView_Previews: PreviewProvider {
    static let authors = ["Barbara Oakley", "Dan Ariely", "James Clear", "Matthew Walker", "Lisa Feldman Barrett", "David Baldacci", "Someone"].sorted()
    
    static var previews: some View {
        AuthorsPickerView(authorListViewModel: AuthorListViewModel(), pickerField: .constant(""), presentPicker: .constant(true))
    }
}
