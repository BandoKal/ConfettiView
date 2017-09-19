//
//  SiloutteView.swift
//  ConfettiView
//
//  Created by Bandy Jason on 9/19/17.
//  Copyright © 2017 ConfettiView. All rights reserved.
//

import Foundation

class SilhouetteView: ParticleImageView {
    
    var possibleColors:[UIColor] = [#colorLiteral(red: 0, green: 0.4443781972, blue: 0.8679092526, alpha: 1),#colorLiteral(red: 0.5667363405, green: 0.8658216596, blue: 0.4901404977, alpha: 1),#colorLiteral(red: 1, green: 0.9203848839, blue: 0.331726253, alpha: 1),#colorLiteral(red: 0.9978461862, green: 0.3002898395, blue: 0.2846045196, alpha: 1),#colorLiteral(red: 0.7954284549, green: 0.3837707639, blue: 0.7679683566, alpha: 1)]
    
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
    init(center point:CGPoint, depth:Double = 1, image: UIImage) {
        super.init(center: point, depth: depth, image: image, renderMode: .alwaysTemplate)
        self.center = point
        
        let index: Int = Int(arc4random_uniform(UInt32(self.possibleColors.count)))
        let color: UIColor = self.possibleColors[index]
        
        self.tintColor = color
    }
}
