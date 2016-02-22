//
//  MainMenuScene.swift
//  SimpleRPG
//
//  Created by Brendon Roberto on 9/23/15.
//  Copyright (c) 2015 SnackpackGames. All rights reserved.
//

import SpriteKit

class MainMenuScene: SKScene {
    override func didMoveToView(view: SKView) {
        let titleLabel = self.childNodeWithName("TitleLabel_0")
        titleLabel?.physicsBody?.affectedByGravity = true
        self.animatePhysics()
    }
    
    func animatePhysics() {
        let physicsAction1 = SKAction.runBlock() {
            self.physicsWorld.gravity = CGVector(dx: 0, dy: 0.01)
        }
        let physicsAction2 = SKAction.runBlock() {
            self.physicsWorld.gravity = CGVector(dx: 0, dy: -0.01)
        }
        let waitAction1 = SKAction.waitForDuration(3.0)
        let waitAction2 = SKAction.waitForDuration(6.0)
        let sequence = SKAction.sequence([physicsAction2, waitAction2, physicsAction1, waitAction2])
        self.runAction(physicsAction1, completion: {
            self.runAction(waitAction1, completion: {
                self.runAction(SKAction.repeatActionForever(sequence))
            })
        })
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let point = touch.locationInNode(self)
            let nodes = self.nodesAtPoint(point)
            for node in nodes {
                if let name = node.name {
                    if name == "Button" {
                        
                    }
                }
            }
        }
    }
}
