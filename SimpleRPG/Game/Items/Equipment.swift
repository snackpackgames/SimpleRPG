//
//  Equipment.swift
//  SimpleRPG
//
//  Created by Brendon Roberto on 2/15/16.
//  Copyright © 2016 SnackpackGames. All rights reserved.
//

import UIKit

class Equipment: NSObject, AttributeModifierSource {
    let id: NSUUID = NSUUID()
    let name: String
    var modifierMap: [String : [AttributeModifier]] = [:]
    var listeners: [AttributeModifierSourceListener] = []
    let endNotificationIdentifier: String
    
    init(name: String, map: [String : [AttributeModifier]]) {
        self.name = name
        self.endNotificationIdentifier = "\(self.name)-\(self.id)"
        self.modifierMap.update(map)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().postNotificationName(self.endNotificationIdentifier, object: nil)
    }
    
    func registerListener(listener: AttributeModifierSourceListener) {
        NSNotificationCenter.defaultCenter().addObserver(listener, selector:"respondToAttributeModifierSourceEndNotification",
            name:self.endNotificationIdentifier, object: self)
    }
    
    func deregisterListener(listener: AttributeModifierSourceListener) {
        NSNotificationCenter.defaultCenter().removeObserver(listener, name: self.endNotificationIdentifier, object: self)
    }
    
    func getIdentifier() -> String {
        return name
    }
    
    func getAttributeModifiers(attribute attribute: Attribute) -> [AttributeModifier] {
        var result: [AttributeModifier] = []
        if let modifiers = self.modifierMap[attribute.getName()] {
            result = modifiers
        }
        return result
    }
    
    func addModifier(attribute attribute: Attribute, modifier: AttributeModifier) {
        if var modifierList = self.modifierMap[attribute.getName()] {
            modifierList.append(modifier)
        } else {
            self.modifierMap[attribute.getName()] = [modifier]
        }
    }
}
