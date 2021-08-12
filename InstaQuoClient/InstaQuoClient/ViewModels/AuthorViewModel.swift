//
//  AuthorViewModel.swift
//  InstaQuoClient
//
//  Created by Nataliia Getlin on 8/11/21.
//

import Combine

final class AuthorViewModel: ObservableObject, Identifiable {
    @Published var author: Author
    private var cancellables: Set<AnyCancellable> = []
    var id = ""
    
    init(author: Author) {
        self.author = author
        $author
            .compactMap {$0.id} // gives us only those values that are not nill
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
    }
    
}
