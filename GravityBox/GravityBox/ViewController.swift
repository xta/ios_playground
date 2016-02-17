//
//  ViewController.swift
//  GravityBox
//
//  Created by Rex on 2/17/16.
//  Copyright © 2016 Rex Feng. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    var square: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupTapGestureRecognizer()
        
        square = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        square.backgroundColor = UIColor.blueColor()
        view.addSubview(square)
        
        animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior(items: [square])
        animator.addBehavior(gravity)
        
        collision = UICollisionBehavior(items: [square])
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupTapGestureRecognizer() {
        let recognizer = UITapGestureRecognizer(target: self, action:Selector("handleTap:"))
        recognizer.delegate = self
        view.addGestureRecognizer(recognizer)
    }
    
    func handleTap(recognizer: UITapGestureRecognizer) {
        let touchInBox = CGRectContainsPoint(square.frame, recognizer.locationInView(self.view))
        
        if touchInBox {
            changeGravityDirection()
        }
    }
    
    func changeGravityDirection() {
        let gravityAngle = gravity.angle
        // print("old angle", gravityAngle)
        
        let newAngle = gravityAngle * -1.0
        // print("new angle", newAngle)
        
        gravity.setAngle(newAngle, magnitude: 1.0)
    }
}

