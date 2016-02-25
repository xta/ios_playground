//
//  Card.swift
//  InfiniteCards
//
//  Created by Rex on 2/24/16.
//  Copyright © 2016 Rex Feng. All rights reserved.
//

import UIKit

struct CardSpec {
    static let width:CGFloat = 100.0
    static let height:CGFloat = 160.0
    static let border = 1.0
    static let offset:CGFloat = 10
}

class Card: UIView {
    
    override init (frame : CGRect) {
        super.init(frame : frame)
        setupCustom()
    }
    
    convenience init (origin: CGPoint) {
        let frame = CGRect(x: origin.x, y: origin.y, width: CardSpec.width, height: CardSpec.height)
        self.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    func setupCustom (){
        self.backgroundColor = randomColor()
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.blackColor().CGColor
        self.layer.borderWidth = 1.0
    }
    
    func origin_below() -> CGPoint {
        return CGPoint(x: self.frame.origin.x - CardSpec.offset, y: self.frame.origin.y - CardSpec.offset)
    }
    
}
