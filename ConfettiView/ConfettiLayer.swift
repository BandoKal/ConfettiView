//
//  ConfettiLayer.swift
//  Confetti
//
//  Created by Or on 04/10/2016.
//  Copyright © 2016 Or. All rights reserved.
//

import Foundation
import UIKit
import CoreMotion


///Manages ShapeViews on a certain designated UIView
class ConfettiLayer {
    
    let view:UIView
    var timer:Timer? = nil
    
    var motionManager = CMMotionManager()
    
    //UIDynamic animator and different Behaviors
    var animator:UIDynamicAnimator
    var itemBehavior = UIDynamicItemBehavior()
    var collisions = UICollisionBehavior()
    
    
    // TODO: create a struct to represent the layer state
    // Initial layer state
    var baseVelocity = CGPoint(x:0.0, y:200.0)
    var calculatedVelocity:CGPoint
    var totalTilt = 1.0
    
    ///The depth that will be simulated by this layer
    var depth:Double
    
    var particleType: ParticleViewType
    
    /**
     Initializes a new confetti layer on a designated view.
     - Parameters:
     - view: The target view where the confetti will be added
     - depth: Simulates depth feeling using size and speed. Default = 1.0
     */
    init(view aView:UIView, depth aDepth:Double = 1.0) {
        view = aView
        particleType = .shape
        animator = UIDynamicAnimator(referenceView: view)
        calculatedVelocity = baseVelocity
        depth = aDepth
        baseVelocity = CGPoint(x: baseVelocity.x / CGFloat(depth), y: baseVelocity.y / CGFloat(depth))
        
        if motionManager.isAccelerometerAvailable {
            motionManager.startAccelerometerUpdates()
        }
        
        setupBehaviors()
        setupTimerLoop()
    }
    
    
    ///Setting up the UIDynamic behaviors
    func setupBehaviors() {
        
        collisions.collisionMode = .boundaries
        resetBounderies()
        
        itemBehavior.allowsRotation = true
        itemBehavior.friction = 0.0
        itemBehavior.resistance = 0
        itemBehavior.elasticity = 0.0
        itemBehavior.density = 0.1
        if #available(iOS 9.0, *) {
            itemBehavior.charge = 20
            
        } else {
            // Fallback on earlier versions
        }
        
        animator.addBehavior(itemBehavior)
        animator.addBehavior(collisions)
    }
    
    func resetBounderies() {
        collisions.removeAllBoundaries()
        collisions.addBoundary(withIdentifier: "left" as NSCopying, from: CGPoint(x:0,y:0), to: CGPoint(x:0,y:self.view.bounds.size.height))
        collisions.addBoundary(withIdentifier: "right" as NSCopying, from: CGPoint(x:self.view.bounds.size.width,y:0), to: CGPoint(x:self.view.bounds.size.width,y:self.view.bounds.size.height))
        
    }
    
    func createBoundary(at location: CGPoint) {
        
        collisions.removeBoundary(withIdentifier: "touch" as NSCopying)
        let rect = CGRect(x: (location.x - 40.0), y: (location.y - 40.0), width: 80.0, height: 50.0)
        let path = UIBezierPath(ovalIn: rect)
        collisions.addBoundary(withIdentifier: "touch" as NSCopying, for: path)
    }
    
    func setupTimerLoop() {
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.onTimeTic), userInfo: nil, repeats: true)
        
    }
    func invalidateTimer() {
        timer?.invalidate()
    }
    
    @objc func onTimeTic()  {
        self.randomlyAddParticle()
        
        self.updateCurrentState(self.motionManager.accelerometerData)
        
    }
    
    
    
    func updateCurrentState(_ accelerometerData:CMAccelerometerData?)  {
        let currentOrientation = UIDevice.current.orientation
        //Calculating the new velocity of the items according to the tilt of the device
        if let accelerometerData = accelerometerData {
            // Up       x = (x * 200/d) ; y = bY + (-y * 300/d)
            // Down     x = (x * 200/d) ; y = -(bY + (-x * 300/d))
            // Left     x = (-y * 200/d) ; y = bY + (-x * 300/d)
            // Right    x = (-y * 200/d) ; y = -(bY + (-y * 300/d))
            var changeInX: CGFloat = 0.0
            var changeInY: CGFloat = 0.0
            switch currentOrientation {
            case .portrait:
                totalTilt = -accelerometerData.acceleration.y
                changeInX = self.baseVelocity.x + CGFloat(accelerometerData.acceleration.x * 200 / self.depth)
                changeInY = CGFloat(-accelerometerData.acceleration.y * 300 / self.depth)
            case .portraitUpsideDown:
                totalTilt = accelerometerData.acceleration.y
                changeInX = CGFloat(accelerometerData.acceleration.x * 200 / self.depth)
                changeInY = -(self.baseVelocity.y + CGFloat(-accelerometerData.acceleration.y * 300 / self.depth))
            case .landscapeLeft:
                totalTilt = -accelerometerData.acceleration.x
                changeInX = CGFloat(-accelerometerData.acceleration.y * 200 / self.depth)
                changeInY = (self.baseVelocity.y + CGFloat(-accelerometerData.acceleration.x * 300 / self.depth))
            case .landscapeRight:
                totalTilt = accelerometerData.acceleration.x
                changeInX = CGFloat(-accelerometerData.acceleration.y * 200 / self.depth)
                changeInY = self.baseVelocity.y + CGFloat(-accelerometerData.acceleration.y * 300 / self.depth)
            default:
                totalTilt = -accelerometerData.acceleration.y
                changeInX = self.baseVelocity.x + CGFloat(accelerometerData.acceleration.x * 200 / self.depth)
                changeInY = CGFloat(-accelerometerData.acceleration.y * 300 / self.depth)
            }
            self.calculatedVelocity = CGPoint(x: changeInX,
                                              y: changeInY)
        }
        self.itemBehavior.items.forEach{ item in
            
            //Changing the item's speed
            let vel = self.itemBehavior.linearVelocity(for: item)
            let delta = CGPoint(x:self.calculatedVelocity.x - vel.x,y:self.calculatedVelocity.y - vel.y)
            self.itemBehavior.addLinearVelocity(delta, for: item)
            
            //Checking if if the item needs to be released
            if let view = item as? UIView {
                if view.frame.origin.y > self.view.frame.size.height {
                    self.collisions.removeItem(item)
                    self.itemBehavior.removeItem(item)
                    view.removeFromSuperview()
                }
                
            }
        }
    }
    
    func randomlyAddParticle() {
        //Add particle in dependency to the tilt of the device to more tilted it is less chance to add another partical
        let chance = Double(arc4random_uniform(UInt32(100)))
        if  chance < self.totalTilt * 80 {
            let randX = Int(arc4random_uniform(UInt32(view.frame.width)))
            self.addParticle(at: CGPoint(x: randX, y: -50))
        }
    }
    
    func addParticle(at point:CGPoint) {
        var view: UIView? = nil
        switch self.particleType {
        case .shape:
            view = ShapeView(center: point,depth: depth)
        case .image(let image):
            //Decrease depth for image because the actual image is too small to see 
            let decreasedDepth = depth - (depth * 0.40)
            view = ParticleImageView(center: point,
                                     depth: decreasedDepth,
                                     image: image)
        case .silhouette(let image):
            view = SilhouetteView(center: point,
                                  depth: depth,
                                  image: image)
        case .string(let text):
            view = StringView(center: point,
                              depth: depth,
                              text: text)
        case .randomEmoji:
            view = EmojiView(center: point,
                             depth: depth)
        }
        guard let particleView = view else { return }
        
        self.view.addSubview(particleView)
        let precentage =  Double(arc4random_uniform(UInt32(101)))/100.0
        particleView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * precentage))
        
        collisions.addItem(particleView)
        itemBehavior.addItem(particleView)
        itemBehavior.addLinearVelocity(calculatedVelocity, for: particleView)
        let spin = Int(arc4random_uniform(UInt32(100)))
        
        if spin > 80 {
            itemBehavior.addAngularVelocity(CGFloat.pi, for: particleView)
        }
    }
}
