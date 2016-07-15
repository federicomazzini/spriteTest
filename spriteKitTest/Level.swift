//
//  Level.swift
//  spriteKitTest
//
//  Created by Federico Mazzini on 7/13/16.
//  Copyright © 2016 Federico Mazzini. All rights reserved.
//

import Foundation

let NumColumns = 80
let NumRows    = 80

class Level {
    
    private var elements = Array2D<Element>(columns: NumColumns, rows: NumRows)
    
    func elementAtColumn(column: Int, row: Int) -> Element? {
        assert(column >= 0 && column < NumColumns)
        assert(row >= 0 && row < NumRows)
        return elements[column, row]
    }
    
    func createElements() -> Array<Element> {
        
        var elementsArray = Array<Element>()
        
        let perlinNoise : [[Double]] = NoiseGenerator.sharedInstance.GeneratePerlinNoise(NumRows, height: NumColumns, octaveCount: 8)
        
        for i in 0...(perlinNoise.count - 1) {
            for j in 0...(perlinNoise[0].count - 1) {
                let element = Element(column: j, row: i, elementType: perlinNoise[i][j])
                elements[j, i] = element
                elementsArray.append(element)
            }
        }

        return elementsArray
    }
}