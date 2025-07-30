//
//  TwoPaneAction.swift
//  SwiftCommander
//
//  Created by Petrik András on 2025. 07. 29..
//

class TwoPaneEvent: Action {
    var sourcePaneAction: PaneAction
    var targetPaneAction: PaneAction
    
    init(sourcePaneAction: PaneAction, targetPaneAction: PaneAction) {
        self.sourcePaneAction = sourcePaneAction
        self.targetPaneAction = targetPaneAction
    }
}
