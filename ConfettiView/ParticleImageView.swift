//
//  ConfettiImageView.swift
//  ConfettiView
//
//  Created by Bandy Jason on 9/19/17.
//  Copyright © 2017 ConfettiView. All rights reserved.
//

import Foundation

class ParticleImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /**
     Initialize a new shape view with random shape and color
     
     - Parameters:
     - center: The center position of the initiaized view
     - depth: The wanted depth, this causes the shape to move faster and appear smaller to create the illusion of depth *Default Value is 1*
     */
    init(center point:CGPoint, depth:Double = 1, image: UIImage, renderMode: UIImageRenderingMode = .alwaysOriginal, shouldScale: Bool = true) {
        super.init(image: image.withRenderingMode(renderMode))
        if shouldScale {
            let ratio = Double(image.size.height / image.size.width)
            let newWidth = 25.0
            let newHeight = newWidth * ratio
            self.frame = CGRect(x: 0, y: 0, width: newWidth/depth, height: newHeight/depth)
        } else {
            self.frame = CGRect(x: 0, y: 0, width: Double(image.size.width)/depth, height: Double(image.size.height)/depth)
        }
        self.center = point
    }
}
