//
//  NoiseGenerator.swift
//  spriteKitTest
//
//  Created by Federico Mazzini on 7/11/16.
//  Copyright © 2016 Federico Mazzini. All rights reserved.
//

import Foundation

infix operator ** { }
func ** (radix: Int, power: Int) -> Int {
    return Int(pow(Double(radix), Double(power)))
}

class NoiseGenerator {
    
    static let sharedInstance = NoiseGenerator()
    
    func Interpolate(xCero: Double, xOne: Double, alpha: Double) -> Double {
        return xCero * (1 - alpha) + alpha * xOne
    }
    
    func generateWhiteNoise(width: Int, height: Int) -> [[Double]] {
        
        var tda = [[Double]]()
        
        for _ in 1...width {
            var h = [Double]()
            for _ in 1...height {
                let r = drand48()
                h.append(r)
            }
            tda.append(h)
        }
        
        return tda
    }
    
    func generateSmoothNoise(baseNoise: [[Double]], octave: Int) -> [[Double]] {
    
        let width  = baseNoise.count
        let height = baseNoise[0].count
        
        var smoothNoise = [[Double]]()
        
        let samplePeriod    : Int    = 2 ** octave
        let sampleFrequency : Double = 1.0 / Double(samplePeriod)
        
        for indexW in 1...width {
    
            //calculate the horizontal sampling indices
            let sample_i0 : Int = Int(floor(Double(indexW) / Double(samplePeriod))) * samplePeriod
            let sample_i1 : Int = (sample_i0 + samplePeriod) % width
            let horizontal_blend : Double = (Double(indexW) - Double(sample_i0)) * sampleFrequency
            
            for indexH in 1...height {
    
                //calculate the vertical sampling indices
                let sample_j0 = Int(floor(Double(indexH) / Double(samplePeriod))) * samplePeriod
                let sample_j1 = (sample_j0 + samplePeriod) % height
                let vertical_blend : Double = (Double(indexH) - Double(sample_j0)) * sampleFrequency
                
                //blend the top two corners
                let top : Double = Interpolate(baseNoise[sample_i0][sample_j0],
                                               xOne: baseNoise[sample_i1][sample_j0],
                                               alpha: horizontal_blend)
                
                //blend the bottom two corners
                let bottom : Double = Interpolate(baseNoise[sample_i0][sample_j1],
                                                  xOne: baseNoise[sample_i1][sample_j1],
                                                  alpha: horizontal_blend)
                
                //final blend
                smoothNoise[indexW][indexH] = Interpolate(top, xOne: bottom, alpha: vertical_blend)
            }
        }
        
        return smoothNoise
    }
    
    func GeneratePerlinNoise(baseNoise: [[Double]], octaveCount: Int) -> [[Double]] {
    
        let width  = baseNoise.count
        let height = baseNoise[0].count
        
        var smoothNoise = [[[Double]]]() //an array of 2D arrays containing
        let persistance = 0.5
        
        //generate smooth noise
        for index in 1...octaveCount {
            smoothNoise[index] = generateSmoothNoise(baseNoise, octave: index)
        }
        
        var perlinNoise    = [[Double]]()
        let amplitude      = 1.0
        var totalAmplitude = 0.0
        
        //blend noise together
        for indexO in octaveCount...1 {
            let amplitude = amplitude * persistance
            totalAmplitude = amplitude + totalAmplitude
            
            for indexW in 1...width {
                for indexH in 1...height {
                    perlinNoise[indexW][indexH] = perlinNoise[indexW][indexH] + smoothNoise[indexO][indexW][indexH] * amplitude
                }
            }
        }
        
        //normalisation
        for indexW in 1...width {
            for indexH in 1...height {
                perlinNoise[indexW][indexH] = perlinNoise[indexW][indexH] / totalAmplitude
            }
        }
        
        return perlinNoise
    }
    
}