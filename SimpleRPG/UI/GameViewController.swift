//
//  GameViewController.swift
//  SimpleRPG
//
//  Created by Brendon Roberto on 9/22/15.
//  Copyright (c) 2015 SnackpackGames. All rights reserved.
//

import UIKit
import SpriteKit

extension SKNode {
    class func unarchiveFromFile(file : String) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
            let sceneData = try! NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe)
            let archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! SKNode
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

class GameViewController: UIViewController {
    
    let logger: Logger = Logger()
    var configurationOptions: ConfigurationOptions = ConfigurationOptions()

    func presentScene(scene: SKScene) {
        self.presentScene(scene, scaleMode: .AspectFill)
    }
    
    func presentScene(scene: SKScene, scaleMode: SKSceneScaleMode) {
        let skView = self.view as! SKView
        scene.scaleMode = scaleMode
        
        skView.showsFPS = configurationOptions.isDebug
        skView.showsNodeCount = configurationOptions.isDebug
        skView.ignoresSiblingOrder = configurationOptions.isDebug
        
        skView.presentScene(scene)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presentScene(MainMenuScene(fileNamed:"MainMenuScene")!)
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return UIInterfaceOrientationMask.AllButUpsideDown
        } else {
            return UIInterfaceOrientationMask.All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
