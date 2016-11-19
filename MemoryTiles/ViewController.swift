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
    var levelLength = 3
    
    var buttons = [UIButton]()
    var stagedLevel = [Int]()
    var playerAnswerSequence = [Int]()
    var timer: Timer!
//--------------------------------------------------------------------------------------------------//
    override func viewDidLoad() {
        super.viewDidLoad()

        buttons.append(buttonOne);buttons.append(buttonTwo);buttons.append(buttonThree);buttons.append(buttonFour);buttons.append(buttonFive);buttons.append(buttonSix);buttons.append(buttonSeven);buttons.append(buttonEight)
        
        assignTagsTo(elements: buttons)

        levelIndicator.alpha = 0
        levelIndicator.text = "Level: \(currentLevel)"
        
        stagedLevel = generateLevelOf(length: levelLength)
        performLevelWith(sequence: stagedLevel)
    }
//--------------------------------------------------------------------------------------------------//
    func assignTagsTo (elements: [UIButton]) {
        var a = 1
        for button in buttons {
            button.tag = a
            button.isEnabled = false
            button.addTarget(self, action: #selector(triggerGlowAt(button:)), for: UIControlEvents.touchUpInside)
            a += 1
        }
    }
//--------------------------------------------------------------------------------------------------//
    func generateLevelOf (length: Int) -> [Int] {
        //Current button
        var buttonNo = 1
        //Local copy of the buttons array
        var buttonsLocal = buttons
        //Creates level sequence, array of ints to be returned as the completed generated sequence
        var levelSequence = [Int]()
        //While the current button is less than or equal to the total length of the desired sequece
        while buttonNo <= length {
            //Shuffle the local array
            buttonsLocal.shuffle()
           // print(buttonsLocal);print("END")
            //Generate a random number between 0 and 7 (That's 8 posible numbers, starting at zero because the indexing of the buttons array does too)
            let random = Int(arc4random_uniform(8))
            print("random: \(random)")
            //Get the button at the index of that random number, get its tag and add it to the level sequence array
            levelSequence.append(buttonsLocal[random].tag)
            //Increase current button number by 1
            buttonNo += 1
        }
        levelSequence.shuffle()
        print("Staged level is: \(levelSequence)")
        return levelSequence
    }
//--------------------------------------------------------------------------------------------------//
    func performLevelWith (sequence: [Int]) {
        //Current button glow of sequence being performed:
        var currentIteration = 0
        //Delay between each glow in seconds
        var glowDelay = DispatchTime.now() + 2
        //Disable buttons so player cannot interupt sequence
        disableButtons()
        for button in sequence {
            //For each item in the current level sequence, after a delay of 2 seconds...
            DispatchQueue.main.asyncAfter(deadline: glowDelay) {
                //Get the button at one less than the current item in the loop (array indexing starts at 0, for loop iteration starts at 1. e.g button six is at array index 5. If we want the fifth button to glow, we target the button at array index 4) and make it glow
                self.buttons[button-1].glowOnce()
                print(self.buttons[button-1].tag)
                //Increase currentIteration to move on to next button in sequence
                currentIteration += 1
                //If we've reach the end of the sequence, enable buttons for user response after 3 seconds
                if currentIteration == sequence.count {
                    print("Staged level has finished playing")
                    self.timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.enableButtons), userInfo: nil, repeats: false)
                }
            }
            glowDelay = glowDelay + 2
        }
    }
//--------------------------------------------------------------------------------------------------//
    func triggerGlowAt(button: UIButton) {
        //Get the tag number of the pressed button
        let pressedButton = button.tag
        //Add the tag number of the pressed button to playerAnswerSequence
        playerAnswerSequence.append(pressedButton)
        //Get the sequence position of the players most recent button press. e.g if the players answer was 3 numbers long, the index position of the most recently added button press is 2.
        let playersCurrentAnswer = playerAnswerSequence.count-1
        //If the length of players answer sequence matches the staged level sequence and the pressed button tag matches the final button in the staged sequence, level complete and buttons disabled
        if playerAnswerSequence.count == stagedLevel.count && stagedLevel[playersCurrentAnswer] == pressedButton {
            print("CORRECT ANSWER, LEVEL COMPLETE")
            disableButtons()
        } else if stagedLevel[playersCurrentAnswer] == pressedButton {
        //Else if the tag value of the pressed button matches the value of the staged button at the sequence position of the players current answer, the right button was pressed but the sequence isn't over
            print("CORRECT ANSWER")
        } else {
        //Else the wrong button was pressed!
            print("WRONG ANSWER")
            disableButtons()
        }
        print(pressedButton)
        button.glowOnce()
    }
//--------------------------------------------------------------------------------------------------//
    func enableButtons () {
        print("Player's answer can begin")
        for button in buttons {
            button.isEnabled = true
        }
    }
//--------------------------------------------------------------------------------------------------//
    func disableButtons () {
        for button in buttons {
            button.isEnabled = false
        }
    }
//--------------------------------------------------------------------------------------------------//
    func displayLevel() {
        levelIndicator.text = "\(currentLevel)"
        UIView.animate(withDuration: 0.7, animations: { 
            self.levelIndicator.alpha = 1
            }) { (true) in
                self.performLevelWith(sequence: self.stagedLevel)
        }
    }
//--------------------------------------------------------------------------------------------------//
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

