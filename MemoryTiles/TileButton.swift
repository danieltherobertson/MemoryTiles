//
//  TileButton.swift
//  MemoryTiles
//
//  Created by Daniel Robertson on 25/10/2016.
//  Copyright © 2016 Daniel Robertson. All rights reserved.
//

import UIKit

@IBDesignable class TileButton: UIButton {

    @IBInspectable var glowColor: UIColor!
    @IBInspectable var audioTone: String!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.borderColor = UIColor.white.cgColor
      //  self.layer.cornerRadius = 10
        self.layer.borderWidth = 4
       // self.alpha = 0.5
    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
