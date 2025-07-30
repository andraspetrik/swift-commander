//
//  PaneAction.swift
//  SwiftCommander
//
//  Created by Petrik András on 2025. 07. 29..
//
import SwiftBus

struct PaneEvent: EventRepresentable {
    let targetPath: String
    let selectedFiles: [String] = []
}
