//
//  CardViewModel.swift
//  InstaQuoClient
//
//  Created by Nataliia Getlin on 8/3/21.
//

import Combine

final class CardViewModel: ObservableObject, Identifiable {
//    private let cardRepository = CardRepository()
    @Published var quoteCard: Card
    private var cancellables: Set<AnyCancellable> = []
    var id = ""
    
    init(quoteCard: Card) {
        self.quoteCard = quoteCard
        $quoteCard
            .compactMap {$0.id} // gives us only those values that are not nill
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
    }
    
}
