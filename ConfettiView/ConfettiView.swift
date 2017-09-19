//
//  ConfettiView.swift
//  Confetti
//
//  Created by Or on 04/10/2016.
//  Copyright © 2016 Or. All rights reserved.
//

import UIKit

public enum ParticleViewType {
    case shape
    case image(image: UIImage)
    case silhouette(image: UIImage)
//    case string(text: String) //More work to do with string... Problems when you have more than one.
    case randomEmoji
}

open class ConfettiView: UIView {
    
    open var isAnimating = true
    
    public var topLayerParticleType = ParticleViewType.shape {
        didSet {
            confettiLayers[0].particleType = topLayerParticleType
        }
    }
    public var middleLayerParticleType = ParticleViewType.shape {
        didSet {
            confettiLayers[1].particleType = middleLayerParticleType
        }
    }
    public var bottomLayerParticleType = ParticleViewType.shape {
        didSet {
            confettiLayers[2].particleType = bottomLayerParticleType
        }
    }
    
    // MARK: Declarations
    var confettiLayers = [ConfettiLayer]()
    
    override open var bounds: CGRect {
        didSet {
            confettiLayers.forEach { layer in layer.resetBounderies() }
        }
    }
    
    // MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addConfetti()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addConfetti()
    }
    
    // MARK: Confetti Methods
    private func addConfetti() {
        self.confettiLayers.append(ConfettiLayer(view: self, depth: 0.85))
        self.confettiLayers.append(ConfettiLayer(view: self, depth: 1.5))
        self.confettiLayers.append(ConfettiLayer(view: self, depth: 2.0))
    }
    
    // MARK: Touches
    override  open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    override  open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    override  open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    // MARK: Controls
    
    /// Stops the animation of all layers
    open func stopAnimating() {
        isAnimating = false
        confettiLayers.forEach { layer in layer.invalidateTimer() }
    }
    
    open func startAnimating() {
        guard isAnimating == false else { return }
        isAnimating = true
        confettiLayers.forEach { layer in layer.setupTimerLoop() }
    }
    
    
}
