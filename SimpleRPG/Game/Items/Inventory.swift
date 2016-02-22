//
//  Inventory.swift
//  SimpleRPG
//
//  Created by Brendon Roberto on 2/15/16.
//  Copyright © 2016 SnackpackGames. All rights reserved.
//

import UIKit

class Inventory: NSObject {
    static 
    let id = NSUUID()
    var displayItems: [InventoryDisplayItem] = []
}
