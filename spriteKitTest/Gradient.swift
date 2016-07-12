//
//  Gradient.swift
//  spriteKitTest
//
//  Created by Federico Mazzini on 7/12/16.
//  Copyright © 2016 Federico Mazzini. All rights reserved.
//

import UIKit

typealias DynamicGradient = Double -> UIColor

func dynamicGradiant(fromColor: UIColor, toColor: UIColor) -> DynamicGradient {
    
    var fromRGBA = [CGFloat](count: 4, repeatedValue: 0.0)
    var toRGBA = [CGFloat](count: 4, repeatedValue: 0.0)
    
    fromColor.getRed(&fromRGBA[0], green: &fromRGBA[1], blue: &fromRGBA[2], alpha: &fromRGBA[3])
    toColor.getRed(&toRGBA[0], green: &toRGBA[1], blue: &toRGBA[2], alpha: &toRGBA[3])
    
    return { (input) in
        var colorComponentsForSuppliedValue = fromRGBA
        
        for index in 0 ..< fromRGBA.count {
            let span = (toRGBA[index] - fromRGBA[index]) * CGFloat(input)
            colorComponentsForSuppliedValue[index] += span
        }
        
        return UIColor(red: colorComponentsForSuppliedValue[0], green: colorComponentsForSuppliedValue[1], blue: colorComponentsForSuppliedValue[2], alpha: colorComponentsForSuppliedValue[3])
    }
}


//A simple gradient:
//let gradient = dynamicGradiant(UIColor.greenColor(), UIColor.redColor())
//
//let aColorBetweenRedAndGreen = gradient(0.5)
