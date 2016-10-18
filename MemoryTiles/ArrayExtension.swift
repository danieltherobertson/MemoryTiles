//
//  ArrayExtension.swift
//  MemoryTiles
//
//  Created by Daniel Robertson on 18/10/2016.
//  Copyright © 2016 Daniel Robertson. All rights reserved.
//

import Foundation

extension Array
{
    /** Randomizes the order of an array's elements. */
    mutating func shuffle()
    {
        for _ in 0..<10
        {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}

