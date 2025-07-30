//
//  PaneAction.swift
//  SwiftCommander
//
//  Created by Petrik András on 2025. 07. 29..
//
import SwiftBus

class PaneEvent: EventRepresentable {
    let currentPath: String
    let selectedFiles: [String]
    
    init(currentPath: String, selectedFiles: [String]) {
        self.currentPath = currentPath
        self.selectedFiles = selectedFiles
    }
}
