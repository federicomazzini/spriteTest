//
//  GameScene.swift
//  spriteKitTest
//
//  Created by Federico Mazzini on 7/12/16.
//  Copyright © 2016 Federico Mazzini. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var level: Level!
    
    let TileWidth: CGFloat = 20.0
    let TileHeight: CGFloat = 20.0
    
    let gameLayer = SKNode()
    let elementsLayer = SKNode()
    
    var cam: SKCameraNode!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) is not used in this app")
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        addChild(gameLayer)
        
        let layerPosition = CGPoint(
            x: -TileWidth * CGFloat(NumColumns) / 2,
            y: -TileHeight * CGFloat(NumRows) / 2)
        
        elementsLayer.position = layerPosition
        gameLayer.addChild(elementsLayer)
    }
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        
        cam = SKCameraNode() //initialize and assign an instance of SKCameraNode to the cam variable.
        cam.setScale(1) //the scale sets the zoom level of the camera on the given position
        
        self.camera = cam //set the scene's camera to reference cam
        self.addChild(cam) //make the cam a childElement of the scene itself.
        
        //position the camera on the gamescene.
        cam.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
    }
    
    func addSpritesForElements(elements: Array<Element>) {
        for element in elements {
            element.sprite.size = CGSize(width: TileWidth, height: TileHeight)
            element.sprite.position = pointForColumn(element.column, row:element.row)
            elementsLayer.addChild(element.sprite)
        }
    }
    
    func pointForColumn(column: Int, row: Int) -> CGPoint {
        return CGPoint(
            x: CGFloat(column)*TileWidth + TileWidth/2,
            y: CGFloat(row)*TileHeight + TileHeight/2)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let firstTouch = touches.first
        let location = (firstTouch?.locationInNode(self))!
        cam.position = location
    }
}
