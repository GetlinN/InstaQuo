//
//  CardListViewModel.swift
//  InstaQuoClient
//
//  Created by Nataliia Getlin on 8/3/21.
//

import Combine


final class CardListViewModel: ObservableObject {
    @Published var cardRepository = CardRepository()
    @Published var authorRepository = AuthorRepository()
    @Published var cardViewModels: [CardViewModel] = []
    private var cancellabels: Set<AnyCancellable> = []
    
    init() {
        cardRepository.$quoteCards
            .map { quoteCards in
                quoteCards.map(CardViewModel.init)
            }
            .assign(to: \.cardViewModels, on: self)
            .store(in: &cancellabels)
    }
    
    func add(_ quoteCard: Card) {
        //handle adding new card
        cardRepository.add(quoteCard)
        
        authorRepository.processAuthorRequest(authorName: quoteCard.bookAuthor, bookTitle: quoteCard.bookTitle)
    }
    
    func remove(_ quoteCard: Card) {
        cardRepository.remove(quoteCard)
    }
    
    func update(_ quoteCard: Card) {
        cardRepository.update(quoteCard)
        
        authorRepository.processAuthorRequest(authorName: quoteCard.bookAuthor, bookTitle: quoteCard.bookTitle)
    }
}
