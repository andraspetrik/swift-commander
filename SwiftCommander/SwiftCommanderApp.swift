//
//  SwiftCommanderApp.swift
//  SwiftCommander
//
//  Created by Petrik András on 2025. 06. 09..
//

import SwiftUI
import SwiftData

@main
struct SwiftCommanderApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 800, minHeight: 600)
        }
    }
    
//    var sharedModelContainer: ModelContainer = {
//        let schema = Schema([
//            Item.self,
//        ])
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//
//        do {
//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()
//
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//        .modelContainer(sharedModelContainer)
//    }
}

