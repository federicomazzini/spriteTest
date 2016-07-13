//
//  Element.swift
//  spriteKitTest
//
//  Created by Federico Mazzini on 7/12/16.
//  Copyright © 2016 Federico Mazzini. All rights reserved.
//

import SpriteKit

enum ElementType: String {
    
    case Player   = "@",
    
    // Terrain
    Mountain = "∆",
    Forest   = "t",
    Grass    = ".",
    Water    = "~",
    Sand     = "s"
}

class Element {
    var column: Int
    var row: Int
    let elementType: ElementType
    var sprite: SKSpriteNode
    
    init(column: Int, row: Int, elementType: Double) {
        self.column = column
        self.row = row
        self.sprite = SKSpriteNode(color: UIColor.lightGrayColor(), size: CGSize(width: 20.0, height: 20.0))
        
        switch elementType {
            case 0...0.3:
                self.elementType = ElementType.Water
                self.sprite.color = UIColor.blueColor()
                break
            case 0.3...0.4:
                self.elementType = ElementType.Sand
                self.sprite.color = UIColor.yellowColor()
                break
            case 0.4...0.8:
                self.elementType = ElementType.Grass
                self.sprite.color = UIColor.greenColor()
                break
            case 0.8...9:
                self.elementType = ElementType.Forest
                self.sprite.color = UIColor.redColor()
                break
            case 0.9...1:
                self.elementType = ElementType.Mountain
                self.sprite.color = UIColor.brownColor()
                break
            default:
                self.elementType = ElementType.Grass
                self.sprite.color = UIColor.lightGrayColor()
                break
        }
    }
    
}
