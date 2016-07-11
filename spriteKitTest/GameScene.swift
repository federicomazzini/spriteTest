//
//  GameScene.swift
//  spriteKitTest
//
//  Created by Federico Mazzini on 7/6/16.
//  Copyright © 2016 Federico Mazzini. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let player = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: 50, height: 50))
    let world = SKSpriteNode(color: UIColor.blueColor(), size: CGSize(width: 1200, height: 1200))
    var cam = SKCameraNode()
    
    override func didMoveToView(view: SKView) {
        anchorPoint = CGPointMake (0.5,0.5)
        backgroundColor = SKColor.whiteColor()
        
        self.camera = cam
        self.addChild(cam)
        
        //position the camera on the gamescene.
        cam.position = CGPoint(x: size.width * 0.1, y: size.height * 0.5)
        
        addChild(world)
        
        player.position = CGPoint(x: size.width * 0.1, y: size.height * 0.5)
        addChild(player)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let firstTouch = touches.first
        let location = (firstTouch?.locationInNode(self))!
        
        player.position = location
        cam.position = location
        
        super.touchesBegan(touches, withEvent:event)
    }
}
