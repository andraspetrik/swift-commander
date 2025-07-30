import SwiftUI

struct TabbedFilePane: View {
    @Binding var tabs: [URL]
    @Binding var selectedIndex: Int

    var body: some View {
        VStack {
            if #available(macOS 15.0, *) {
                TabView {
                    ForEach(tabs.indices, id: \.self) { index in
                        FilePane(path: $tabs[selectedIndex])
                            .tabItem {
                                Text("Home")
                            }.tag(index)
                    }
                    ////                    Text(tabs[index].lastPathComponent).tag(index)
                    //
                    //                }
                    
                    //                Tab("Received", systemImage: "tray.and.arrow.down.fill") {
                    //                    FilePane(path: $tabs[selectedIndex])
                    //                }
                    //                .badge(2)
                    //
                    //
                    //                Tab("Sent", systemImage: "tray.and.arrow.up.fill") {
                    //                    SentView()
                    //                }
                    //
                    //
                    //                Tab("Account", systemImage: "person.crop.circle.fill") {
                    //                    AccountView()
                    //                }
                    //                .badge("!")
                }.tabViewStyle(.grouped)
            } else {
                // TODO Old version
                // Fallback on earlier versions
            }
            
//            Picker("", selection: $selectedIndex) {
//                ForEach(tabs.indices, id: \.self) { index in
//                    Text(tabs[index].lastPathComponent).tag(index)
//                }
//            }
//            .pickerStyle(SegmentedPickerStyle())
//            .padding(.horizontal)
//
//            if tabs.indices.contains(selectedIndex) {
//                FilePane(path: $tabs[selectedIndex])
//            } else {
//                Text("Invalid tab selection")
//            }
//
//            HStack {
//                Button("New Tab") {
//                    tabs.append(FileManager.default.homeDirectoryForCurrentUser)
//                    selectedIndex = tabs.count - 1
//                }
//                Button("Close Tab") {
//                    guard tabs.count > 1 else { return }
//                    tabs.remove(at: selectedIndex)
//                    selectedIndex = max(0, selectedIndex - 1)
//                }
//            }
//            .padding(.horizontal)
        }
    }
}
