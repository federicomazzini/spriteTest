//
//  GameViewController.swift
//  spriteKitTest
//
//  Created by Federico Mazzini on 7/6/16.
//  Copyright (c) 2016 Federico Mazzini. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = NoiseGenerator.sharedInstance.generateNoiseImage(self.view.frame.size)
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.layer.magnificationFilter = kCAFilterNearest
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}
