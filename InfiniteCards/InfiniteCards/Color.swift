//
//  Color.swift
//  InfiniteCards
//
//  Created by Rex on 2/24/16.
//  Copyright © 2016 Rex Feng. All rights reserved.
//

import UIKit

// via http://stackoverflow.com/questions/24263007/

public func color(hex:String) -> UIColor {
    var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
    
    if (cString.hasPrefix("#")) {
        cString = (cString as NSString).substringFromIndex(1)
    }
    
    if (cString.characters.count != 6) {
        return UIColor.grayColor()
    }
    
    let rString = (cString as NSString).substringToIndex(2)
    let gString = ((cString as NSString).substringFromIndex(2) as NSString).substringToIndex(2)
    let bString = ((cString as NSString).substringFromIndex(4) as NSString).substringToIndex(2)
    
    var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
    NSScanner(string: rString).scanHexInt(&r)
    NSScanner(string: gString).scanHexInt(&g)
    NSScanner(string: bString).scanHexInt(&b)
    
    
    return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
}

public func randomColor() -> UIColor {
    let color_strings = [
        "#0074D9", // blue
        "39CCCC", // teal
        "3D9970", // olive
        "01FF70", // lime
        "FFDC00", // yellow
        "FF4136", // red
        "B10DC9", // purple
        "FF851B", // orange
        "7FDBFF", // aqua
    ]
    
    return color(color_strings.random())
}