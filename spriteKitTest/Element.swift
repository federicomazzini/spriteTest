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
    let cookieType: ElementType
    var sprite: SKLabelNode?
    
    init(column: Int, row: Int, cookieType: ElementType) {
        self.column = column
        self.row = row
        self.cookieType = cookieType
    }
}
