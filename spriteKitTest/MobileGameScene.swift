//
//  MobileGameScene.swift
//  spriteKitTest
//
//  Created by Federico Mazzini on 7/14/16.
//  Copyright © 2016 Federico Mazzini. All rights reserved.
//

import UIKit

class MobileGameScene: SharedGameScene {

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let firstTouch = touches.first
        let location = (firstTouch?.locationInNode(self))!
        cam.position = location
    }
}