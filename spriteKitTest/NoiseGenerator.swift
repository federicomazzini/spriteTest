//
//  NoiseGenerator.swift
//  spriteKitTest
//
//  Created by Federico Mazzini on 7/11/16.
//  Copyright © 2016 Federico Mazzini. All rights reserved.
//

import UIKit

infix operator ** { }
func ** (radix: Int, power: Int) -> Int {
    return Int(pow(Double(radix), Double(power)))
}

class NoiseGenerator {
    
    static let sharedInstance = NoiseGenerator()
    
    private let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
    private let bitmapInfo:CGBitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.PremultipliedFirst.rawValue)
    
    private let ARC4RANDOM_MAX = 0x100000000
    
    //MARK: Image generation
    
    struct PixelData {
        var a:UInt8 = 255
        var r:UInt8
        var g:UInt8
        var b:UInt8
    }
    
    func imageFromARGB32Bitmap(pixels:[PixelData], width:Int, height:Int)->UIImage {
        let bitsPerComponent:Int = 8
        let bitsPerPixel:Int = 32
        
        var data = pixels // Copy to mutable []
        let providerRef = CGDataProviderCreateWithCFData(NSData(bytes: &data, length: data.count * sizeof(PixelData)))
        
        let cgim = CGImageCreate(width, height, bitsPerComponent, bitsPerPixel, width * Int(sizeof(PixelData)), rgbColorSpace,	bitmapInfo, providerRef, nil, true, CGColorRenderingIntent.RenderingIntentDefault)
        
        return UIImage(CGImage: cgim!);
    }
    
    func generateNoiseImage(size:CGSize) -> UIImage {
        
        let width = Int(size.width)
        let height = Int(size.height)
        
        let perlinNoise : [[Double]] = NoiseGenerator.sharedInstance.GeneratePerlinNoise(width, height: height, octaveCount: 8)
        
        var pixelArray = [PixelData](count: width * height, repeatedValue: PixelData(a: 255, r:0, g: 0, b: 0))
        
        for i in 0 ..< (height - 1) {
            for j in 0 ..< (width - 1) {
                var val = abs(Float(perlinNoise[j][i]))
                
                if val > 1 {
                    val = 1
                }
                
                let index = i * width + j
                let u_I = UInt8(val * 255)
                pixelArray[index].r = u_I
                pixelArray[index].g = u_I
                pixelArray[index].b = u_I
            }
        }
        
        let outputImage = imageFromARGB32Bitmap(pixelArray, width: width, height: height)
        
        return outputImage
    }
    
    //MARK: Noise generation
    
    func Interpolate(xCero: Double, xOne: Double, alpha: Double) -> Double {
        return xCero * (1 - alpha) + alpha * xOne
    }
    
    func generateWhiteNoise(width: Int, height: Int) -> [[Double]] {
        
        var tda = [[Double]]()
        
        for _ in 1...width {
            var h = [Double]()
            for _ in 1...height {
//                let r = drand48()
                let r = Double(arc4random()) / Double(ARC4RANDOM_MAX)
                
                h.append(Double(r))
            }
            tda.append(h)
        }
        
        return tda
    }
    
    func generateSmoothNoise(baseNoise: [[Double]], octave: Int) -> [[Double]] {
    
        let width  = baseNoise.count - 1
        let height = baseNoise[0].count - 1
        
        var smoothNoise = [[Double]]()
        
        let samplePeriod    : Int    = 2 ** octave
        let sampleFrequency : Double = 1.0 / Double(samplePeriod)
        
        for indexW in 0...width {
    
            //calculate the horizontal sampling indices
            let sample_i0 : Int = Int(floor(Double(indexW) / Double(samplePeriod))) * samplePeriod
            let sample_i1 : Int = (sample_i0 + samplePeriod) % width
            let horizontal_blend : Double = (Double(indexW) - Double(sample_i0)) * sampleFrequency
            
            smoothNoise.append([Double]())
            for indexH in 0...height {
    
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
                smoothNoise[indexW].append(Interpolate(top, xOne: bottom, alpha: vertical_blend))
            }
        }
        
        return smoothNoise
    }
    
    func GeneratePerlinNoise(width: Int, height: Int, octaveCount: Int) -> [[Double]] {
        
        let baseNoise : [[Double]] = NoiseGenerator.sharedInstance.generateWhiteNoise(width, height: height)
        
        var smoothNoise = [[[Double]]]() //an array of 2D arrays containing
        let persistance = 0.5
        
        //generate smooth noise
        for index in 0...octaveCount - 1 {
            smoothNoise.append(generateSmoothNoise(baseNoise, octave: index))
        }
        
        var perlinNoise = generateWhiteNoise(width, height: height)
        
        let amplitude      = 1.0
        var totalAmplitude = 0.0
        
        //blend noise together
        for octave in (octaveCount - 1).stride(to: 0, by: -1) {
            let amplitude = amplitude * persistance
            totalAmplitude = amplitude + totalAmplitude
            
            for indexW in 0...width - 1 {
                
                for indexH in 0...height - 1 {
                    perlinNoise[indexW][indexH] = (perlinNoise[indexW][indexH] + smoothNoise[octave][indexW][indexH] * amplitude)
                }
            }
        }
        
        //normalisation
        for indexW in 0...width - 1 {
            for indexH in 0...height - 1 {
                perlinNoise[indexW][indexH] = perlinNoise[indexW][indexH] / totalAmplitude
            }
        }
        
        return perlinNoise
    }
    
}