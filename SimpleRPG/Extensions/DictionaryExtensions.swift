//
//  DictionaryExtensions.swift
//  SimpleRPG
//
//  Created by Brendon Roberto on 2/15/16.
//  Copyright © 2016 SnackpackGames. All rights reserved.
//

import Foundation

extension Dictionary {
    mutating public func update(other: Dictionary) {
        for (key, value) in other {
            self.updateValue(value, forKey: key)
        }
    }
}