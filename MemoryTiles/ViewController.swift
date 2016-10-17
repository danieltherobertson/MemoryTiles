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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var buttons = [UIButton]()
        buttons.append(buttonOne);buttons.append(buttonTwo);buttons.append(buttonThree);buttons.append(buttonFour);buttons.append(buttonFive);buttons.append(buttonSix);buttons.append(buttonSeven);buttons.append(buttonEight)
        
        for button in buttons {
            button.glowOnce()
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

