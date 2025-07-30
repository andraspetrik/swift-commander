//
//  TwoPaneAction.swift
//  SwiftCommander
//
//  Created by Petrik András on 2025. 07. 29..
//

import SwiftBus

class TwoPaneEvent: EventRepresentable {
    let sourcePaneAction: PaneEvent
    let targetPaneAction: PaneEvent
    
    init(sourcePaneAction: PaneEvent, targetPaneAction: PaneEvent) {
        self.sourcePaneAction = sourcePaneAction
        self.targetPaneAction = targetPaneAction
    }
}
