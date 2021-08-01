//
//  InstaQuoClientApp.swift
//  InstaQuoClient
//
//  Created by Nataliia Getlin on 7/30/21.
//

import SwiftUI

@main
struct InstaQuoClientApp: App {
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
