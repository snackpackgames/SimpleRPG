//
//  Engine.swift
//  SimpleRPG
//
//  Created by Brendon Roberto on 11/3/15.
//  Copyright © 2015 SnackpackGames. All rights reserved.
//

import UIKit

class Engine: NSObject {

    let stateMachine = StateMachine()
    
    init(state: State, name: String) {
        stateMachine.add(name, state: state)
        stateMachine.push(name)
    }
}
