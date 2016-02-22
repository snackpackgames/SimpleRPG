//
//  StateMachine.swift
//  SimpleRPG
//
//  Created by Brendon Roberto on 9/22/15.
//  Copyright (c) 2015 SnackpackGames. All rights reserved.
//

import UIKit

class StateMachine: NSObject {
    let logger: Logger = Logger()
    
    var states: [String: State] = [
        "DefaultState": DefaultState()
    ]
    var stateStack: [State] = []
    
    func update(elapsedTime: Float) {
        logger.log("Entered Update for object \(self.description).")
        var state = self.stateStack.last
        state?.update(elapsedTime)
    }
    
    func render() {
        logger.log("Entered Render for object \(self.description).")
        var state = self.stateStack.last
        state?.render()
    }
    
    func change(name: String, params: AnyObject?) {
        stateStack.last?.onExit(params)
        self.push(name)
        stateStack.last?.onEnter(params)
    }
    
    func add(name: String, state: State) {
        if let _ = states[name] {
            logger.log("Skipping addition of duplicate state to state map in object \(self.description).")
        } else {
            states[name] = state
        }
    }
    
    func push(name: String) {
        if let state = states[name] {
            stateStack.append(state)
        } else {
            logger.log("Tried to instantiate unknown state \(name).", level: .Error)
        }
    }
    
    func pop() -> State {
        return stateStack.removeLast()
    }
}
