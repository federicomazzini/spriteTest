//
//  GameViewController.swift
//  spriteKitTest
//
//  Created by Federico Mazzini on 7/6/16.
//  Copyright (c) 2016 Federico Mazzini. All rights reserved.
//

import SpriteKit

class GameViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var scene: MobileGameScene!
    var level: Level!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        imageView.image = NoiseGenerator.sharedInstance.generateNoiseImage(self.view.frame.size)
//        imageView.contentMode = UIViewContentMode.ScaleAspectFit
//        imageView.layer.magnificationFilter = kCAFilterNearest
        imageView.hidden = true
        
        // Configure the view.
        let skView = view as! SKView
        skView.multipleTouchEnabled = false
        
        // Create and configure the scene.
        scene = MobileGameScene(size: skView.bounds.size)
        scene.scaleMode = .AspectFill
        
        // Present the scene.
        skView.presentScene(scene)
        
        level = Level()
        scene.level = level
        
        beginGame()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func beginGame() {
        shuffle()
    }
    
    func shuffle() {
        let newelements = level.createElements()
        scene.addSpritesForElements(newelements)
    }
}
