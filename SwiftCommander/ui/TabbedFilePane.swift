import SwiftUI

struct TabbedFilePane: View {
    @Binding var tabs: [URL]
    @Binding var selectedIndex: Int

    var body: some View {
        VStack {
            Picker("", selection: $selectedIndex) {
                ForEach(tabs.indices, id: \.self) { index in
                    Text(tabs[index].lastPathComponent).tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)

            if tabs.indices.contains(selectedIndex) {
                FilePane(path: $tabs[selectedIndex])
            } else {
                Text("Invalid tab selection")
            }

            HStack {
                Button("New Tab") {
                    tabs.append(FileManager.default.homeDirectoryForCurrentUser)
                    selectedIndex = tabs.count - 1
                }
                Button("Close Tab") {
                    guard tabs.count > 1 else { return }
                    tabs.remove(at: selectedIndex)
                    selectedIndex = max(0, selectedIndex - 1)
                }
            }
            .padding(.horizontal)
        }
    }
}
