//
//  ViewController.swift
//  InfiniteCards
//
//  Created by Rex on 2/22/16.
//  Copyright © 2016 Rex Feng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var deck = [Card]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        setupCards()
    }

    // MARK: user interaction
    
        // TODO
    
    // MARK: card helpers
    
    func setupCards() {
        let first_square = Card(origin: topCardOrigin())
        view.addSubview(first_square)
        
        let second_square = Card(origin: first_square.origin_below())
        view.insertSubview(second_square, belowSubview: first_square)
        
        let third_square = Card(origin: second_square.origin_below())
        view.insertSubview(third_square, belowSubview: second_square)
    }
    
    func topCardOrigin() -> CGPoint {
        let screen = UIScreen.mainScreen().bounds
        let screenWidth = screen.size.width
        let screenHeight = screen.size.height

        let originX = screenWidth/2 - CardSpec.width/2
        let originY = screenHeight/2 - CardSpec.height/2
        
        return CGPoint(x: originX, y: originY)
    }
    
}
