//
//  ArrayExtensions.swift
//  SimpleRPG
//
//  Created by Brendon Roberto on 2/10/16.
//  Copyright © 2016 SnackpackGames. All rights reserved.
//

import Foundation

extension Array {
    public func each(action: (_: Element) -> ()) {
        for e in self {
            action(e)
        }
    }
}