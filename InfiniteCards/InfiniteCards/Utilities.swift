//
//  Utilities.swift
//  InfiniteCards
//
//  Created by Rex on 2/24/16.
//  Copyright © 2016 Rex Feng. All rights reserved.
//

import Foundation

extension Array {
    func random() -> Element {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}