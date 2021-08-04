//
//  InstaQuoClientApp.swift
//  InstaQuoClient
//
//  Created by Nataliia Getlin on 7/30/21.
//

import SwiftUI
import Firebase


@main
struct InstaQuoClientApp: App {
//    @StateObject private var modelData = ModelData()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
//                .environmentObject(modelData)
        }
    }
}
