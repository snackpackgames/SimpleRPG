//
//  InventoryDisplayItem.swift
//  SimpleRPG
//
//  Created by Brendon Roberto on 2/15/16.
//  Copyright © 2016 SnackpackGames. All rights reserved.
//

import UIKit

protocol InventoryDisplayItem {
    var thumbnail: UIImage { get }
    var fullImage: UIImage { get }
    var displayName: String { get }
    var shortDescription: String { get }
    var fullDescription: NSAttributedString { get }
}