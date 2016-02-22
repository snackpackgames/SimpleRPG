//
//  AttributeModifierSource.swift
//  SimpleRPG
//
//  Created by Brendon Roberto on 2/10/16.
//  Copyright © 2016 SnackpackGames. All rights reserved.
//

import Foundation

public protocol AttributeModifierSource {
    func registerListener(listener: AttributeModifierSourceListener)
    func deregisterListener(listener: AttributeModifierSourceListener)
    func getIdentifier() -> String
    func getAttributeModifiers(attribute attribute: Attribute) -> [AttributeModifier]
}

@objc public protocol AttributeModifierSourceListener {
    func respondToAttributeModifierSourceEndNotification(notification: NSNotification)
}