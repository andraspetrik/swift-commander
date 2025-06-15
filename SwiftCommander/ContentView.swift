//
//  ContentView.swift
//  SwiftCommander
//
//  Created by Petrik András on 2025. 06. 09..
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var leftTabs: [URL] = [FileManager.default.homeDirectoryForCurrentUser]
    @State private var rightTabs: [URL] = [FileManager.default.homeDirectoryForCurrentUser]
    @State private var selectedLeftTab = 0
    @State private var selectedRightTab = 0
    
//    init() {
//        print("leftPath: \(FileManager.default.homeDirectoryForCurrentUser)")
//        print("rightPath: \(FileManager.default.homeDirectoryForCurrentUser)")
//    }

    var body: some View {
        HStack {
            TabbedFilePane(tabs: $leftTabs, selectedIndex: $selectedLeftTab)
            Divider()
            TabbedFilePane(tabs: $rightTabs, selectedIndex: $selectedRightTab)
        }
    }
}

//#Preview {
//    ContentView()
//        .modelContainer(for: Item.self, inMemory: true)
//}
