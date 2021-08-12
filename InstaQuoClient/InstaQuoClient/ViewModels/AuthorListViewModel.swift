//
//  AuthorViewModel.swift
//  InstaQuoClient
//
//  Created by Nataliia Getlin on 8/11/21.
//

import Combine


final class AuthorListViewModel: ObservableObject {
    @Published var authorRepository = AuthorRepository()
    @Published var authorViewModels: [AuthorViewModel] = []
    private var cancellabels: Set<AnyCancellable> = []
    
    init() {
        authorRepository.$authors
            .map { author in
                author.map(AuthorViewModel.init)
            }
            .assign(to: \.authorViewModels, on: self)
            .store(in: &cancellabels)
    }
    
    func add(_ author: Author) {
        authorRepository.add(author)
    }
    
    func remove(_ author: Author) {
        authorRepository.remove(author)
    }
    
    func update(_ author: Author) {
        authorRepository.update(author)
    }
}
