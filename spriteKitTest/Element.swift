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
        #if TARGET_OS_IPHONE
            self.sprite = SKSpriteNode(color: UIColor.lightGrayColor(), size: CGSize(width: 20.0, height: 20.0))
        #else
            self.sprite = SKSpriteNode(color: NSColor.lightGrayColor(), size: CGSize(width: 20.0, height: 20.0))
        #endif
        
        switch elementType {
            case 0...0.4:
                self.elementType = ElementType.Water
                #if TARGET_OS_IPHONE
                    self.sprite.color = UIColor.blueColor()
                #else
                    self.sprite.color = NSColor.blueColor()
                #endif
                break
            case 0.4...0.45:
                self.elementType = ElementType.Sand
                #if TARGET_OS_IPHONE
                    self.sprite.color = UIColor.yellowColor()
                #else
                    self.sprite.color = NSColor.yellowColor()
                #endif
                break
            case 0.4...0.8:
                self.elementType = ElementType.Grass
                #if TARGET_OS_IPHONE
                    self.sprite.color = UIColor.greenColor()
                #else
                    self.sprite.color = NSColor.greenColor()
                #endif
                break
            case 0.8...9:
                self.elementType = ElementType.Forest
                #if TARGET_OS_IPHONE
                    self.sprite.color = UIColor.redColor()
                #else
                    self.sprite.color = NSColor.redColor()
                #endif
                break
            case 0.9...1:
                self.elementType = ElementType.Mountain
                #if TARGET_OS_IPHONE
                    self.sprite.color = UIColor.brownColor()
                #else
                    self.sprite.color = NSColor.brownColor()
                #endif
                break
            default:
                self.elementType = ElementType.Grass
                #if TARGET_OS_IPHONE
                    self.sprite.color = UIColor.lightGrayColor()
                #else
                    self.sprite.color = NSColor.lightGrayColor()
                #endif
                break
        }
    }
    
}
