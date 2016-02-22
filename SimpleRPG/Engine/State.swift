//
//  State.swift
//  SimpleRPG
//
//  Created by Brendon Roberto on 9/22/15.
//  Copyright (c) 2015 SnackpackGames. All rights reserved.
//

import UIKit

protocol State {
    mutating func update(elapsedTime: Float)
    mutating func render()
    func onEnter(params: AnyObject?)
    func onExit(params: AnyObject?)
}

class DefaultState: NSObject, State {
    let logger: Logger = Logger()
    
    func update(elapsedTime: Float) {
        logger.log("Update called for object \(self.description) with elapsedTime \(elapsedTime).")
    }
    
    func render() {
        logger.log("Render called for object \(self.description).")
    }
    
    func onEnter(params: AnyObject?) {
        logger.log("OnEnter called for object \(self.description) with params \(params).")
    }
    
    func onExit(params: AnyObject?) {
        logger.log("OnExit called for object \(self.description) with params \(params).")
    }
}