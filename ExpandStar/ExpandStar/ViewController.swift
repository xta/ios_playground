//
//  ViewController.swift
//  ExpandStar
//
//  Created by Rex on 2/21/16.
//  Copyright © 2016 Rex Feng. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var star: StarView!
    
    enum StarState {
        case Small, Large
        
        mutating func toggle() {
            switch self {
            case .Small:
                self = .Large
            case .Large:
                self = .Small
            }
        }
    }
    
    var starState = StarState.Small {
        didSet {
            toggleStarSize()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let recognizer = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
        recognizer.delegate = self
        view.addGestureRecognizer(recognizer)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleTap(recognizer: UITapGestureRecognizer) {
        let touchInStar = CGRectContainsPoint(star.frame, recognizer.locationInView(self.view))
        
        if touchInStar {
            starState.toggle()
        }
    }
    
    func toggleStarSize() {
        if starState == .Small {
            UIView.animateWithDuration(0.1, animations: {
                self.star.transform = CGAffineTransformIdentity
            })
            
        } else if starState == .Large {
            UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
                self.star.transform = CGAffineTransformMakeScale(20, 20)
            }, completion: nil)
        }
    }
    
}
