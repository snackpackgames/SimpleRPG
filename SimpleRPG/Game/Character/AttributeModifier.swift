//
//  AttributeModifier.swift
//  SimpleRPG
//
//  Created by Brendon Roberto on 2/10/16.
//  Copyright © 2016 SnackpackGames. All rights reserved.
//

import UIKit

public class AttributeModifier: CustomStringConvertible {
    
    // MARK: - Constants 
    
    static private let defaultType = AttributeModifierType.Final
    
    // MARK: - Properties
    
    public let source: AttributeModifierSource
    public let value: Attribute.AttributeValue
    public let operation: Attribute.AttributeValueOperation
    public let type: AttributeModifierType
    
    // MARK: - CustomStringConvertible Properties
    
    public var description: String {
        return "AttributeModifier - \(type) - \(source) - \(value)"
    }
    
    // MARK: - Initialization
    
    init(value: Attribute.AttributeValue, source: AttributeModifierSource,
        operation: Attribute.AttributeValueOperation, type: AttributeModifierType) {
            self.value = value
            self.source = source
            self.type = type
            self.operation = operation
    }
    
    convenience init(value: Int, variance: Int, source: AttributeModifierSource) {
        self.init(value: Attribute.AttributeValue(value: value, variance: variance), source: source, operation: (+), type: AttributeModifier.defaultType)
    }
    
    convenience init(value: Int, variance: Int, source: AttributeModifierSource, type: AttributeModifierType) {
        self.init(value: Attribute.AttributeValue(value: value, variance: variance), source: source, operation: (+), type: type)
    }
    
    convenience init(value: Attribute.AttributeValue, source: AttributeModifierSource) {
        self.init(value: value, source: source, operation: (+), type: AttributeModifier.defaultType)
    }
    
    convenience init(value: Attribute.AttributeValue, source: AttributeModifierSource, type: AttributeModifierType) {
        self.init(value: value, source: source, operation: (+), type: type)
    }
    
    convenience init(value: Attribute.AttributeValue, source: AttributeModifierSource, operation: Attribute.AttributeValueOperation) {
        self.init(value: value, source: source, operation: operation, type: AttributeModifier.defaultType)
    }
    
    convenience init(value: Int, variance: Int, source: AttributeModifierSource,
                     operation: Attribute.AttributeValueOperation) {
        self.init(value: Attribute.AttributeValue(value: value, variance: variance), source: source, operation: operation, type: AttributeModifier.defaultType)
    }
    
    convenience init(value: Int, variance: Int, source: AttributeModifierSource,
                     operation: Attribute.AttributeValueOperation, type: AttributeModifierType) {
        self.init(value: Attribute.AttributeValue(value: value, variance: variance), source: source, operation: operation, type: type)
    }
    
    // MARK: - Public Methods
    
    public func apply(value: Attribute.AttributeValue) -> Attribute.AttributeValue {
        return operation(value, self.value)
    }
    
    // MARK: - Nested Types
    
    public enum AttributeModifierType: String {
        case Raw = "RAW"
        case Final = "FINAL"
    }
}

