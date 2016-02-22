//
//  StarView.swift
//  ExpandStar
//
//  Created by Rex on 2/21/16.
//  Copyright © 2016 Rex Feng. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable public class StarView: UIView {
    
    // based on https://github.com/ipraba/EPShapes
    
    @IBInspectable public var fillColor: UIColor = UIColor.clearColor()
    @IBInspectable public var corners: Int = 5
    @IBInspectable public var extrusionPercent: Int = 33
    @IBInspectable public var shapeMask: Bool = false
    
    @IBInspectable public var strokeColor: UIColor = UIColor.blackColor()
    @IBInspectable public var scaling: Double = 1.0
    @IBInspectable public var strokeWidth: CGFloat = 1.0
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        config()
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        config()
    }
    
    public func config() {
        if corners > 0 {
            drawStar()
        }
    }
    
    func drawStar() {
        
        layer.sublayers?
            .filter  { $0.name == "Star" }
            .forEach { $0.removeFromSuperlayer() }
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.backgroundColor = UIColor.clearColor().CGColor
        shapeLayer.name = "Star"
        shapeLayer.path = UIBezierPath().getStars(frame, scale: scaling, corners: corners, extrusion: extrusionPercent).CGPath
        
        if shapeMask {
            shapeLayer.fillRule = kCAFillRuleNonZero
            self.layer.mask = shapeLayer
        } else  {
            shapeLayer.lineWidth = strokeWidth
            shapeLayer.strokeColor = strokeColor.CGColor
            shapeLayer.fillColor = fillColor.CGColor
            self.layer.addSublayer(shapeLayer)
        }
    }
    
}

public extension UIBezierPath  {
    
    func getStars(originalRect: CGRect, scale: Double, corners: Int, extrusion: Int) -> UIBezierPath {
        
        let scaledWidth = (originalRect.size.width * CGFloat(scale))
        let scaledXValue = ((originalRect.size.width) - scaledWidth) / 2
        let scaledHeight = (originalRect.size.height * CGFloat(scale))
        let scaledYValue = ((originalRect.size.height) - scaledHeight) / 2
        
        let scaledRect = CGRect(x: scaledXValue, y: scaledYValue, width: scaledWidth, height: scaledHeight)
        
        drawStars(originalRect, scaledRect: scaledRect, corners: corners, extrusion: extrusion)
        
        return self
    }
    
    
    func drawStars(originalRect: CGRect, scaledRect: CGRect, corners: Int, extrusion: Int) {
        
        let center = CGPointMake(originalRect.width/2, originalRect.height/2)
        
        var angle = -CGFloat( M_PI / 2.0 )
        
        let angleCounter = CGFloat( M_PI * 2.0 / Double(corners * 2) )
        let radius = min(scaledRect.size.width/2, scaledRect.size.height/2)
        
        let extrusion = radius * CGFloat(extrusion) / 100
        
        self.moveToPoint(CGPointMake(radius * cos(angle) + center.x, radius * sin(angle) + center.y))
        for i in 1...(corners * 2)  {
            if i % 2 != 0 {
                self.addLineToPoint(CGPointMake(radius * cos(angle) + center.x, radius * sin(angle) + center.y))
            } else {
                self.addLineToPoint(CGPointMake(extrusion * cos(angle) + center.x, extrusion * sin(angle) + center.y))
            }
            
            angle += angleCounter
        }
        self.closePath()
        
    }
    
}

