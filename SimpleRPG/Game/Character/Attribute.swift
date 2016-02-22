//
//  Attribute.swift
//  SimpleRPG
//
//  Created by Brendon Roberto on 2/10/16.
//  Copyright © 2016 SnackpackGames. All rights reserved.
//

import UIKit
import GameplayKit

public class Attribute: CustomStringConvertible, AttributeModifierSourceListener {
    
    // MARK: - Class Properties
    
    public static var attributes: [String : Attribute] = [:]
    
    private static let baseValueKey = "BaseValue"
    private static let baseVarianceKey = "BaseVariance"
    private static let nameKey = "Name"
    
    // MARK: - Properties
    
    public typealias AttributeParentTuple = (attribute: Attribute, operation: AttributeValueOperation)
    
    private var parents: [AttributeParentTuple] = []
    private var modifiers: [String : AttributeModifier] = [:]
    private let baseValue: Int
    private let baseVariance: Int
    private let type: AttributeType
    private let name: String
    
    // MARK: - CustomStringConvertible Properties
    
    public var description: String {
        return "\(name): \(getValue()) \n\t - \(modifiers)"
    }
    
    // MARK: - Initialization
    
    init(baseValue: Int, baseVariance: Int, name: String, type: AttributeType, parents: [AttributeParentTuple], modifiers: [String : AttributeModifier]) {
        self.baseValue = baseValue
        self.baseVariance = baseVariance
        self.name = name
        self.type = type
        self.parents.appendContentsOf(parents)
        self.modifiers.update(modifiers)
        Attribute.attributes.updateValue(self, forKey: name)
    }
    
    convenience init(baseValue: Int, baseVariance: Int, name: String) {
        self.init(baseValue: baseValue, baseVariance: baseVariance, name: name, type: .Static, parents: [], modifiers: [:])
    }
    
    convenience init(name: String, baseVariance: Int, parents: [AttributeParentTuple]) {
        self.init(baseValue: 0, baseVariance: baseVariance, name: name, type: .Derived, parents: parents, modifiers: [:])
    }
    
    convenience init!(resourceNamed resource: String) {
        if let path = NSBundle.mainBundle().pathForResource(resource, ofType: "plist") {
            if let values = NSDictionary(contentsOfFile: path) {
                self.init(baseValue: values[Attribute.baseValueKey] as! Int, baseVariance: values[Attribute.baseVarianceKey] as! Int, name: values[Attribute.nameKey] as! String)
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    deinit {
        for (_, modifier) in modifiers.values.enumerate() {
            modifier.source.deregisterListener(self)
        }
    }
    
    // MARK: - Public Methods
    
    public func addModifier(modifier modifier: AttributeModifier) {
        synced(modifiers) { [unowned self] in
            modifier.source.registerListener(self)
            self.modifiers[modifier.source.getIdentifier()] = modifier
        }
    }
    
    public func addModifier(source source: AttributeModifierSource) {
        let modifiers = source.getAttributeModifiers(attribute: self)
        modifiers.each { [unowned self] modifier in
            self.addModifier(modifier: modifier)
        }
    }
    
    public func getName() -> String {
        return name
    }
    
    public func getValue() -> AttributeValue {
        let base = getBaseValue()
        // Apply raw values directly to result
        let result = modifiers.values.filter({ ($0 as AttributeModifier).type == .Raw }).reduce(base) { $0 + $1.apply(base) }
        return modifiers.values.filter({ ($0 as AttributeModifier).type == .Final }).reduce(result) { $1.apply($0) }
    }
    
    public func getBaseValue() -> AttributeValue {
        var result = AttributeValue(value: baseValue, variance: baseVariance)
        switch self.type {
        case .Derived:
            // Use the AttributeValueOperation of the tuple
            result = parents.reduce(result) { $1.operation($0, $1.attribute.getValue()) }
        case .Static:
            break
        }
        return result
    }
    
    // MARK: - AttributeModifierSourceListener Methods
    
    @objc public func respondToAttributeModifierSourceEndNotification(notification: NSNotification) {
        if let source = notification.object as? AttributeModifierSource {
            synced(modifiers) { [unowned self] in
                source.deregisterListener(self)
                self.modifiers.removeValueForKey(source.getIdentifier())
            }
        }
    }
    
    // MARK: - Nested Types
    
    public typealias AttributeValueOperation = (AttributeValue, AttributeValue) -> AttributeValue
    
    public struct AttributeValue: CustomStringConvertible {
        
        public var description: String {
            return variance > 0 ? "\(minimumValue())~\(maximumValue())" : "\(minimumValue())"
        }
        
        private var value = 0
        private var variance = 0
        
        init(value: Int, variance: Int) {
            self.value = value
            self.variance = variance
        }

        mutating func setValue(value: Int) -> AttributeValue {
            self.value = value
            return self
        }
        
        mutating func setVariance(variance: Int) -> AttributeValue {
            self.variance = variance
            return self
        }
        
        func getVariance() -> Int {
            return variance
        }
        
        func minimumValue() -> Int {
            return value
        }
        
        func maximumValue() -> Int {
            return value + variance
        }
        
        func getRandomValue() -> Int {
            var result: Int
            if #available(iOS 9.0, *) {
                result = value + GKRandomSource.sharedRandom().nextIntWithUpperBound(variance + 1)
            } else {
                result = value + Int(arc4random_uniform(UInt32(variance + 1)))
            }
            return result
        }
    }

    public enum AttributeType {
        case Static
        case Derived
    }
}

infix operator + { associativity left precedence 140 }
public func +(left: Attribute.AttributeValue, right: Attribute.AttributeValue) -> Attribute.AttributeValue {
    let result = Attribute.AttributeValue(value: left.value + right.value, variance: left.variance)
    return result
}

public func +(left: Attribute.AttributeValue, right: Int) -> Attribute.AttributeValue {
    let result = Attribute.AttributeValue(value: left.value + right, variance: left.variance)
    return result
}

public func +(left: Int, right:Attribute.AttributeValue) -> Attribute.AttributeValue {
    let result = Attribute.AttributeValue(value: right.value + left, variance: right.variance)
    return result
}


infix operator * { associativity left precedence 140 }
public func *(left: Attribute.AttributeValue, right: Attribute.AttributeValue) -> Attribute.AttributeValue {
    let result = Attribute.AttributeValue(value: left.value * right.value, variance: left.variance)
    return result
}

public func *(left: Int, right: Attribute.AttributeValue) -> Attribute.AttributeValue {
    let result = Attribute.AttributeValue(value: right.value * left, variance: right.variance)
    return result
}

public func *(left: Attribute.AttributeValue, right: Int) -> Attribute.AttributeValue {
    let result = Attribute.AttributeValue(value: left.value * right, variance: left.variance)
    return result
}

public func *(left: Attribute.AttributeValue, right: Double) -> Attribute.AttributeValue {
    let result = Attribute.AttributeValue(value: Int(Double(left.value) * right), variance: left.variance)
    return result
}

public func *(left: Double, right: Attribute.AttributeValue) -> Attribute.AttributeValue {
    let result = Attribute.AttributeValue(value: Int(Double(right.value) * left), variance: right.variance)
    return result
}


