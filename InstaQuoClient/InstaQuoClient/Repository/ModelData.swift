//
//  ModelData.swift
//  InstaQuoClient
//
//  Created by Nataliia Getlin on 7/30/21.
//

import Foundation
import Combine


//SwiftUI subscribes to observable object, and updates any views that need refreshing when the data changes.

final class ModelData: ObservableObject {
    
    // creates an array of cards that initialized from data.json
    @Published var quoteCards: [Card] = []
//        = load("data.json")
}



func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
