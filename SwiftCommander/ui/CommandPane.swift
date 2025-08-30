//
//  CommandPane.swift
//  SwiftCommander
//
//  Created by Petrik András on 2025. 06. 25..
//
import SwiftUI

struct CommandPane: View {
        
        var body: some View {
            
            let actions = [
                ("Open With", { print("Open With") }),
                ("Edit", { print("Edit") }),
                ("Copy", { showCopyAlert("Copy") }),
                ("Move", { print("Move") }),
                ("Rename", { print("Rename") }),
                ("New Folder", { print("New Folder") }),
                ("Delete", { print("Delete") })
            ]
            
            GeometryReader { geo in
                let buttonWidth = geo.size.width / CGFloat(actions.count)
                
                HStack(spacing: 0) {
                    ForEach(actions.indices, id: \.self) { i in
                        Button(actions[i].0, action: actions[i].1)
                            .frame(width: buttonWidth, height: 30) // ✅ fixed equal width
                            .background(Color.gray.opacity(0.1))
                            .border(Color.gray.opacity(0.3), width: 0.5)
                            .buttonStyle(.plain)
                    }
                }
            }
            .frame(height: 30) // toolbar height
//            .background(Color.green)
            .padding()
        }
    
    func showNativeAlert(_ title: String) {
        let alert = NSAlert()
        alert.messageText = title
        alert.informativeText = "This alert is not tied to SwiftUI views."
        alert.alertStyle = .informational
        alert.addButton(withTitle: "OK")
        alert.addButton(withTitle: "Cancel")

        if let window = NSApplication.shared.windows.first {
            alert.beginSheetModal(for: window) { response in
                if response == .alertFirstButtonReturn {
                    print("User clicked OK")
                } else {
                    print("User clicked Cancel")
                }
            }
        } else {
            alert.runModal()
        }
    }
    
    func showCopyAlert(_ title: String) {
        let alert = NSAlert()
//        alert.messageText = title
        alert.informativeText = "Copy \(title) to"
        alert.alertStyle = .informational
        alert.addButton(withTitle: "Copy")
        alert.addButton(withTitle: "Cancel")

        if let window = NSApplication.shared.windows.first {
            alert.beginSheetModal(for: window) { response in
                if response == .alertFirstButtonReturn {
                    print("User clicked OK")
                } else {
                    print("User clicked Cancel")
                }
            }
        } else {
            alert.runModal()
        }
    }
}
