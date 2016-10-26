//
//  ViewController.swift
//  MemoryTiles
//
//  Created by Daniel Robertson on 16/10/2016.
//  Copyright © 2016 Daniel Robertson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var buttonOne: TileButton!
    @IBOutlet weak var buttonTwo: TileButton!
    @IBOutlet weak var buttonThree: TileButton!
    @IBOutlet weak var buttonFour: TileButton!
    @IBOutlet weak var buttonFive: TileButton!
    @IBOutlet weak var buttonSix: TileButton!
    @IBOutlet weak var buttonSeven: TileButton!
    @IBOutlet weak var buttonEight: TileButton!
    
    @IBOutlet weak var levelIndicator: UILabel!
    
    var currentLevel = 1
    var buttons = [UIButton]()
    var stagedLevel = [Int]()
    var playerAnswer = [Int]()
    var timer: Timer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(buttonOne.glowColor)
        
        buttons.append(buttonOne);buttons.append(buttonTwo);buttons.append(buttonThree);buttons.append(buttonFour);buttons.append(buttonFive);buttons.append(buttonSix);buttons.append(buttonSeven);buttons.append(buttonEight)
        
        assignTagsTo(elements: buttons)

        levelIndicator.alpha = 0
        levelIndicator.text = String(currentLevel)
        
        stagedLevel = generateLevelOf(length: 5)
        print(stagedLevel)
        performLevelWith(sequence: stagedLevel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func assignTagsTo (elements: [UIButton]) {
        var a = 1
        for button in buttons {
            button.tag = a
            button.isEnabled = false
            button.addTarget(self, action: #selector(triggerGlowAt(button:)), for: UIControlEvents.touchUpInside)
            a += 1
        }
    }
    
    func generateLevelOf (length: Int) -> [Int] {
        var buttonNo = 1
        var buttonsLocal = buttons
        var levelSequence = [Int]()
        while buttonNo <= length {
            buttonsLocal.shuffle()
           // print(buttonsLocal);print("END")
            let random = Int(arc4random_uniform(3))
            levelSequence.append(buttonsLocal[random].tag)
            buttonNo += 1
        }
        levelSequence.shuffle()
        return levelSequence
    }
    
    func performLevelWith (sequence: [Int]) {
        var currentIteration = 0
        var when = DispatchTime.now() + 2
        let enableTime = DispatchTime.now() + 8
        disableButtons()
        for item in sequence {
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.buttons[item-1].glowOnce()
                currentIteration += 1
                print(currentIteration)
                if currentIteration == sequence.count {
                    self.timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.enableButtons), userInfo: nil, repeats: false)
                }
            }
            when = when + 2
        }
        
        print("level done")
//
    }
    
    func triggerGlowAt(button: UIButton) {
        let pressedButton = button.tag
        playerAnswer.append(pressedButton)
        
        let playersAnswer = playerAnswer.count-1
        
        if playerAnswer.count == stagedLevel.count && stagedLevel[playersAnswer] == pressedButton {
            print("CORRECT ANSWER, LEVEL COMPLETE")
            
            disableButtons()
        
        } else if stagedLevel[playersAnswer] == pressedButton {
            print("CORRECT ANSWER")
        } else {
            print("WRONG ANSWER")
            disableButtons()
        }
        button.glowOnce()
    }
    
    func enableButtons () {
        print("helloooo")
        for button in buttons {
            button.isEnabled = true
        }
    }
    
    func disableButtons () {
        for button in buttons {
            button.isEnabled = false
        }
    }
    
//    func checkForPatternsIn (sequence:[Int]) {
//        var localSequence = sequence
//        for (button, index) in localSequence.enumerated() {
//            //Get the first button in the sequence, then get the one directly after
//            let buttonA = button
//            let buttonB = sequence[index+1]
//            if buttonA + 1 == buttonB || buttonA - 1 == buttonB {
//                //If we find a pair of numbers that numerically follow on from each other, reshuffle the array, break for loop and restart the checking process
//                localSequence.shuffle()
//                self.checkForPatternsIn(sequence: localSequence)
//                break
//            }
//        }
//    }
}

