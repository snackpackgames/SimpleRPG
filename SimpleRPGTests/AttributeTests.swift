//
//  AttributeTests.swift
//  SimpleRPG
//
//  Created by Brendon Roberto on 2/10/16.
//  Copyright © 2016 SnackpackGames. All rights reserved.
//

import XCTest

class AttributeTests: XCTestCase {

    var str = Attribute(baseValue: 10, baseVariance: 0, name: "STR")
    var crt = Attribute(baseValue: 10, baseVariance: 0, name: "CRT")
    var dex = Attribute(baseValue: 10, baseVariance: 0, name: "DEX")
    var luk = Attribute(baseValue: 10, baseVariance: 0, name: "LUK")
    var acc: Attribute!
    var dmg: Attribute!
    
    override func setUp() {
        super.setUp()
        
        acc = Attribute(name: "ACC", baseVariance: 10, parents: [(dex, { total, parent in total + (parent * 0.8) }),
            (luk, { total, parent in total + (parent * 0.5) })])
        let dmgLukOperation: Attribute.AttributeValueOperation = { total, parent in Attribute.AttributeValue(value: total.minimumValue(), variance:
            (total.getVariance() + Int(Double(parent.minimumValue()) * 0.3))) }
        let dmgParentsArray: [Attribute.AttributeParentTuple] = [(str, { total, parent in total + (parent * 0.9) }),
            (dex, { total, parent in total + (parent * 0.3) }),
            (luk, dmgLukOperation)]
        dmg = Attribute(name: "DMG", baseVariance: 6, parents: dmgParentsArray)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testCreateAttribute() {
        XCTAssert(acc.getValue().minimumValue() == 13, "ACC has wrong minimum value.")
        XCTAssert(acc.getValue().maximumValue() == 23, "ACC has wrong maxiumum value.")
        
        XCTAssert(dmg.getValue().minimumValue() == 12, "DMG has wrong minimum value.")
        XCTAssert(dmg.getValue().maximumValue() == 21, "DMG has wrong maximum value.")
        
        print("\(str)\n\(dex)\n\(luk)\n\(crt)\n\(acc)\n\(dmg)")
    }
    
    func testReadAttributeFromPlist() {
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
