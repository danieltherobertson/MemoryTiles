//
//  ViewController.swift
//  MemoryTiles
//
//  Created by Daniel Robertson on 16/10/2016.
//  Copyright © 2016 Daniel Robertson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var buttonThree: UIButton!
    @IBOutlet weak var buttonFour: UIButton!
    @IBOutlet weak var buttonFive: UIButton!
    @IBOutlet weak var buttonSix: UIButton!
    @IBOutlet weak var buttonSeven: UIButton!
    @IBOutlet weak var buttonEight: UIButton!
    @IBOutlet weak var levelIndicator: UILabel!
    
    var currentLevel = 1
    var buttons = [UIButton]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        buttons.append(buttonOne);buttons.append(buttonTwo);buttons.append(buttonThree);buttons.append(buttonFour);buttons.append(buttonFive);buttons.append(buttonSix);buttons.append(buttonSeven);buttons.append(buttonEight)
        
        levelIndicator.alpha = 0
        levelIndicator.text = String(currentLevel)
        
       
        
        UIView.animate(withDuration: 12, animations: {
            self.levelIndicator.alpha = 1.0
            }) { (completion) in
                print("doot")
                
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func generateLevelOf (length: Int) -> [UIButton] {
        var buttonNo = 1
        var buttonsLocal = buttons
        var levelSequence = [UIButton]()
        while buttonNo < length {
            buttonsLocal.shuffle()
            levelSequence.append(buttonsLocal[0])
            buttonNo += 1
        }
        
        return levelSequence
    }
    
    func performLevelWith (sequence: [UIButton]) {
        for item in sequence {
            item.glowOnce()
        }
    }
}

