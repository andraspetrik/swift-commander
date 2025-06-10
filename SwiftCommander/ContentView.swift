//
//  ContentView.swift
//  SwiftCommander
//
//  Created by Petrik András on 2025. 06. 09..
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var leftPath: URL = FileManager.default.homeDirectoryForCurrentUser
    @State private var rightPath: URL = FileManager.default.homeDirectoryForCurrentUser
    
//    init() {
//        print("leftPath: \(FileManager.default.homeDirectoryForCurrentUser)")
//        print("rightPath: \(FileManager.default.homeDirectoryForCurrentUser)")
//    }

    var body: some View {
        HStack {
            FilePane(path: $leftPath)
            Divider()
            FilePane(path: $rightPath)
        }
    }
}

//#Preview {
//    ContentView()
//        .modelContainer(for: Item.self, inMemory: true)
//}
