import SwiftUI

struct FilePane: View {
    @Binding var path: URL
    @State private var files: [URL] = []
    @State private var selectedFile: URL?

    var body: some View {
        VStack {
            HStack {
                TextField("Path", text: Binding(
                    get: { path.path },
                    set: { path = URL(fileURLWithPath: $0); loadFiles() }
                ))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Reload") {
                    loadFiles()
                }
            }
            .padding(.horizontal)

            List(selection: $selectedFile) {
                ForEach(files, id: \.self) { file in
                    FileRow(file: file, onOpen: {
                        openIfDirectory(file)
                    })
                }
            }
            .contextMenu {
                Button("Copy") { copyFile() }
                Button("Rename") { renameFile() }
                Button("Delete") { deleteFile() }
            }
            .onAppear(perform: loadFiles)
        }
    }

    private func loadFiles() {
        do {
            print("Path: \($path)")
            
            files = try FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            
//            files.forEach({ print("File: \($0)") })
        } catch {
            print("Error loading files: \(error)")
        }
    }
    
    private func openIfDirectory(_ file: URL) {
            print("- openIfDirectory - file: \(file)")
            var isDirectory: ObjCBool = false
            if FileManager.default.fileExists(atPath: file.path, isDirectory: &isDirectory), isDirectory.boolValue {
                path = file
                loadFiles()
            }
        }

    private func copyFile() {
        guard let file = selectedFile else { return }
        let destination = path.appendingPathComponent("Copy_of_" + file.lastPathComponent)
        do {
            try FileManager.default.copyItem(at: file, to: destination)
            loadFiles()
        } catch {
            print("Copy failed: \(error)")
        }
    }

    private func renameFile() {
        guard let file = selectedFile else { return }
        let alert = NSAlert()
        alert.messageText = "Rename File"
        alert.informativeText = "Enter a new name for \(file.lastPathComponent)"
        alert.alertStyle = .informational
        alert.addButton(withTitle: "OK")
        alert.addButton(withTitle: "Cancel")

        let input = NSTextField(frame: NSRect(x: 0, y: 0, width: 200, height: 24))
        alert.accessoryView = input

        let response = alert.runModal()
        if response == .alertFirstButtonReturn, !input.stringValue.isEmpty {
            let newURL = file.deletingLastPathComponent().appendingPathComponent(input.stringValue)
            do {
                try FileManager.default.moveItem(at: file, to: newURL)
                loadFiles()
            } catch {
                print("Rename failed: \(error)")
            }
        }
    }

    private func deleteFile() {
        guard let file = selectedFile else { return }
        do {
            try FileManager.default.removeItem(at: file)
            loadFiles()
        } catch {
            print("Delete failed: \(error)")
        }
    }
    
    private func showQuickLook(for file: URL) {
        NSWorkspace.shared.activateFileViewerSelecting([file])
    }
}

struct FileRow: View {
    let file: URL
    let onOpen: () -> Void

    var body: some View {
        HStack {
            Text(file.lastPathComponent)
                .frame(minWidth: 200, alignment: .leading)
            Spacer()
            Text(fileSizeString(for: file))
                .frame(width: 80, alignment: .trailing)
            Text(modificationDateString(for: file))
                .frame(width: 140, alignment: .trailing)
        }
        .padding(.vertical, 2)
        .onTapGesture(count: 2, perform: onOpen)
    }

    private func fileSizeString(for url: URL) -> String {
        do {
            let resourceValues = try url.resourceValues(forKeys: [.fileSizeKey])
            if let size = resourceValues.fileSize {
                let formatter = ByteCountFormatter()
                formatter.countStyle = .file
                return formatter.string(fromByteCount: Int64(size))
            }
        } catch {}
        return "-"
    }

    private func modificationDateString(for url: URL) -> String {
        do {
            let resourceValues = try url.resourceValues(forKeys: [.contentModificationDateKey])
            if let date = resourceValues.contentModificationDate {
                let formatter = DateFormatter()
                formatter.dateStyle = .short
                formatter.timeStyle = .short
                return formatter.string(from: date)
            }
        } catch {}
        return "-"
    }
}

struct KeyCatcherView: NSViewRepresentable {
    var onKeyDown: (NSEvent) -> Void

    func makeNSView(context: Context) -> NSView {
        let view = KeyCatcher()
        view.onKeyDown = onKeyDown
        return view
    }

    func updateNSView(_ nsView: NSView, context: Context) {}

    class KeyCatcher: NSView {
        var onKeyDown: ((NSEvent) -> Void)?

        override var acceptsFirstResponder: Bool { true }

        override func keyDown(with event: NSEvent) {
            onKeyDown?(event)
        }

        override func viewDidMoveToWindow() {
            DispatchQueue.main.async {
                self.window?.makeFirstResponder(self)
            }
        }
    }
}

