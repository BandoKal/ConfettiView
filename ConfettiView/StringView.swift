//
//  EmojiView.swift
//  ConfettiView
//
//  Created by Bandy Jason on 9/19/17.
//  Copyright © 2017 ConfettiView. All rights reserved.
//

import Foundation

class StringView: ParticleImageView {
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
    init?(center point:CGPoint, depth:Double = 1, text: String) {
        guard let textImage = text.image() else {
            return nil
        }
        super.init(center: point, depth: depth, image: textImage)
    }
    
}


extension String {
    func image() -> UIImage? {
        let size = CGSize(width: 30, height: 35)
        UIGraphicsBeginImageContextWithOptions(size, false, 0);
        UIColor.clear.set()
        let rect = CGRect(origin: CGPoint.zero, size: size)
        UIRectFill(CGRect(origin: CGPoint.zero, size: size))
        (self as NSString).draw(in: rect, withAttributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 30)])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
