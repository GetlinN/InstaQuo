//
//  experiment.swift
//  InstaQuoClient
//
//  Created by Nataliia Getlin on 8/4/21.
//

import SwiftUI

struct experiment: View {
    
    @State private var inputText = "Some text"
    @State private var wordCount: Int = 0
    
    @ObservedObject var card: CardViewModel
    
    @State private var editTextEditor = false
    @State private var isEditing = false
    let fontSize = CGFloat(20)
 
    var body: some View {
        ScrollView {
            
            ZStack(alignment: .topTrailing) {
                TextEditor(text: $inputText)
                    .font(.body)
                    .padding()
                    .padding(.top, 20)
                    .onChange(of: inputText) { value in
                        card.quoteCard.quote = inputText
//                        let words = inputText.split { $0 == " " || $0.isNewline }
//                        self.wordCount = words.count
                    }
     
                Text("\(wordCount) words")
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(.trailing)
            }
            
            VStack {
                VStack(alignment: .leading) {
                    Label("Quote", systemImage: "1.circle")
                        .foregroundColor(Color.gray)

                    TextEditor(text: $card.quoteCard.quote)
                        .disabled(!editTextEditor)
                        .frame(minWidth: 0, maxWidth: 350, minHeight: 0, maxHeight: 1500, alignment: .leading)
                        .lineLimit(10)
                        .font(.custom("HelveticaNeue", size: fontSize))
    //                    .lineSpacing(5)
                }.frame(height: 200)
            }
            
           
        }
                
        
    }
}

struct experiment_Previews: PreviewProvider {
    
    static let fakeCard = Card(quote: "Humans are not sleeping the way nature intended. The number of sleep bouts, the duration of sleep, and when sleep occurs has all been comprehensively distorted by modernity.", bookTitle: "Why We Sleep: Unlocking the Power of Sleep and Dreams", bookAuthor: "Matthew Walker", personalNote: "Matthew Walker is a British scientist and professor of neuroscience and psychology at the University of California, Berkeley. His research focuses on the impact of sleep on human health and disease. Previously, he was a professor of psychiatry at Harvard Medical School.", isFavorite: true)

    static var previews: some View {
        experiment(card: CardViewModel(quoteCard: fakeCard))
    
    }
}

