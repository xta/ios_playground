//
//  ViewController.swift
//  FlingView
//
//  Created by Rex on 2/20/16.
//  Copyright © 2016 Rex Feng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // NOTE: the code in ViewController has issues and is intended as an experimental concept for educational purposes (not for production)
    
    var animator: UIDynamicAnimator!
    var collision: UICollisionBehavior!
    
    var circle: UIView!
    var circleDriftBehavior: UIDynamicItemBehavior?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        animator = UIDynamicAnimator(referenceView: self.view)
        
        addCircle()
        addCirclePanGesture()
    }
    
    func addCircle() {
        circle = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        circle.backgroundColor = UIColor.orangeColor()
        circle.layer.cornerRadius = 50
        circle.clipsToBounds = true
        
        circle.userInteractionEnabled = true
        view.addSubview(circle)
        
        collision = UICollisionBehavior(items: [circle])
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
    }
    
    func addCirclePanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: "didPan:")
        panGesture.minimumNumberOfTouches = 1
        panGesture.maximumNumberOfTouches = 1
        circle.addGestureRecognizer(panGesture)
    }
    
    func didPan(recognizer: UIPanGestureRecognizer) {
        guard let ourView = recognizer.view else { return }
        
        if recognizer.state == UIGestureRecognizerState.Began {
            
            if let circleDriftBehavior = circleDriftBehavior {
                
                // this does NOT work. the circle is not responsive on change
                circleDriftBehavior.removeItem(circle)
                animator.removeBehavior(circleDriftBehavior)
                
                print("behaviors: (count: ", animator.behaviors.count, ") :", animator.behaviors)
                
                // this works, but it also removes the UICollisionBehavior we want to keep
                // animator.removeAllBehaviors()
            }
            
        } else if recognizer.state == UIGestureRecognizerState.Changed {
            
            let translation = recognizer.translationInView(self.view)
            ourView.center = CGPoint(x: ourView.center.x + translation.x, y: ourView.center.y + translation.y)
            recognizer.setTranslation(CGPointZero, inView: self.view)
            
        } else if (recognizer.state == UIGestureRecognizerState.Ended || recognizer.state == UIGestureRecognizerState.Cancelled ) {
            
            circleDriftBehavior = UIDynamicItemBehavior(items: [circle])
            
            if let circleDriftBehavior = circleDriftBehavior {
                let velocity = recognizer.velocityInView(circle.superview)
                circleDriftBehavior.addLinearVelocity(velocity, forItem: circle)
                
                animator.addBehavior(circleDriftBehavior)
                animator.updateItemUsingCurrentState(ourView)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
