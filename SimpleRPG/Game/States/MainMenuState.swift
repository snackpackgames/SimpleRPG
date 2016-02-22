//
//  MainMenuState.swift
//  SimpleRPG
//
//  Created by Brendon Roberto on 9/22/15.
//  Copyright (c) 2015 SnackpackGames. All rights reserved.
//

import UIKit

class MainMenuState: NSObject, State {
    var viewController: GameViewController?
    
    init(viewController: GameViewController) {
        self.viewController = viewController
    }
    
    func update(elapsedTime: Float) {
        // TODO: Stub
    }
    
    func render() {
        // TODO: Stub
    }
    
    func onEnter(params: AnyObject?) {
        if let vc = self.viewController {
            vc.presentScene(MainMenuScene(fileNamed:"MainMenuScene")!)
        }
    }
    
    func onExit(params: AnyObject?) {
        // TODO: Stub
    }
}
