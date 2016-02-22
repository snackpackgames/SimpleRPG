//
//  Synced.swift
//  SimpleRPG
//
//  Created by Brendon Roberto on 2/10/16.
//  Copyright © 2016 SnackpackGames. All rights reserved.
//

import Foundation

public func synced(lock: AnyObject, closure: () -> ()) {
    objc_sync_enter(lock)
    closure()
    objc_sync_exit(lock)
}