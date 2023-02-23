//
//  LoadingIndicatorView.swift
//  iosApp
//
//  Created by Nurgun Nalyiakhov on 18.05.2022.
//

import UIKit

extension CAPropertyAnimation {
    enum Key: String {
        var path: String {
            return rawValue
        }
        
        case strokeStart = "strokeStart"
        case strokeEnd = "strokeEnd"
        case strokeColor = "strokeColor"
        case rotationZ = "transform.rotation.z"
        case scale = "transform.scale"
    }
    
    convenience init(key: Key) {
        self.init(keyPath: key.path)
    }
}

extension CGRect {
    var center: CGPoint {
        return CGPoint(x: midX, y: midY)
    }
}

extension CGSize {
    var min: CGFloat {
        return CGFloat.minimum(width, height)
    }
}

@IBDesignable
public class LoadingIndicator: UIView {
    
    @IBInspectable
    public var color: UIColor = .link {
        didSet {
            indicator?.strokeColor = color.cgColor
        }
    }
    
    @IBInspectable
    public var lineWidth: CGFloat = 4.0 {
        didSet {
            indicator?.lineWidth = lineWidth
            setNeedsLayout()
        }
    }
    
    private let indicator: CAShapeLayer? = CAShapeLayer()
    private let animator: LoadingIndicatorAnimator? = LoadingIndicatorAnimator()
    
    var isAnimating = false
    
    convenience init() {
        self.init(frame: .zero)
        self.setup()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    private func setup() {
        indicator?.strokeColor = color.cgColor
        indicator?.fillColor = nil
        indicator?.lineWidth = lineWidth
        indicator?.strokeStart = 0.0
        indicator?.strokeEnd = 0.0
        layer.addSublayer(indicator ?? CAShapeLayer())
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isUserInteractionEnabled = false
        self.widthAnchor.constraint(equalToConstant: 30).isActive = true
        self.heightAnchor.constraint(equalTo: self.widthAnchor).isActive = true
    }
}

extension LoadingIndicator {
    override public var intrinsicContentSize: CGSize {
        return CGSize(width: 24, height: 24)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        indicator?.frame = bounds
        
        let diameter = bounds.size.min - (indicator?.lineWidth ?? 4.0)
        let path = UIBezierPath(center: bounds.center, radius: diameter / 2)
        indicator?.path = path.cgPath
    }
}

extension LoadingIndicator {
    
    public func startAnimating() {
        guard !self.isAnimating else { return }
        self.isAnimating = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            guard self.isAnimating else { return }
            self.animator?.addAnimation(to: self.indicator)
        }
    }
    
    public func stopAnimating() {
        guard isAnimating else { return }
        
        animator?.removeAnimation(from: indicator)
        isAnimating = false
    }
}

final class LoadingIndicatorAnimator {
    
    enum Animation: String {
        var key: String {
            return rawValue
        }
        
        case spring = "material.indicator.spring"
        case rotation = "material.indicator.rotation"
    }
    
    public func addAnimation(to layer: CALayer?) {
        layer?.add(rotationAnimation(), forKey: Animation.rotation.key)
        layer?.add(springAnimation(), forKey: Animation.spring.key)
    }
    
    public func removeAnimation(from layer: CALayer?) {
        layer?.removeAnimation(forKey: Animation.rotation.key)
        layer?.removeAnimation(forKey: Animation.spring.key)
    }
}

extension LoadingIndicatorAnimator {
    
    private func rotationAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(key: .rotationZ)
        animation.duration = 4
        animation.fromValue = 0
        animation.toValue = (2.0 * .pi)
        animation.repeatCount = .infinity
        
        return animation
    }
    
    private func springAnimation() -> CAAnimationGroup {
        let animation = CAAnimationGroup()
        animation.duration = 1.5
        animation.animations = [
            strokeStartAnimation(),
            strokeEndAnimation(),
            strokeCatchAnimation(),
            strokeFreezeAnimation()
        ]
        animation.repeatCount = .infinity
        
        return animation
    }
    
    private func strokeStartAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(key: .strokeStart)
        animation.duration = 1
        animation.fromValue = 0
        animation.toValue = 0.15
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        return animation
    }
    
    private func strokeEndAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(key: .strokeEnd)
        animation.duration = 1
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        return animation
    }
    
    private func strokeCatchAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(key: .strokeStart)
        animation.beginTime = 1
        animation.duration = 0.5
        animation.fromValue = 0.15
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        return animation
    }
    
    private func strokeFreezeAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(key: .strokeEnd)
        animation.beginTime = 1
        animation.duration = 0.5
        animation.fromValue = 1
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        return animation
    }
}

extension UIBezierPath {
    convenience init(center: CGPoint, radius: CGFloat) {
        self.init(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat(.pi * 2.0), clockwise: true)
    }
}
