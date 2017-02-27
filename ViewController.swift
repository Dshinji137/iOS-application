//
//  ViewController.swift
//  What is the number II
//
//  Created by Hengzhi Ding on 17/2/21.
//  Copyright © 2017年 Hengzhi Ding. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var A = 0
    var B = 0
    var guessTime = 0
    let maxTime = 10
    var ans:[Int] = [0,0,0,0]
    var isOver = true
    
    @IBOutlet weak var myTitle: UILabel!
    @IBOutlet weak var Judge: UILabel!
    @IBOutlet weak var guessResult: UILabel!
    @IBOutlet weak var inputNumber: UITextField!
    
    @IBAction func Reset(sender: UIButton) {
        ans = distinctNumber()
        isOver = false
        guessTime = 0
        Judge.hidden = true
        guessResult.hidden = true
    }
    @IBAction func myGuess(sender: UIButton) {
        if !isOver {
            let input = inputNumber.text!
            let len = input.characters.count
            inputNumber.text = ""
            if(len != 4) {
                guessResult.hidden = false
                guessResult.text = "Please guess a 4-digit number!"
            }
            else {
                guessTime++
                var guess:[Character] = [Character](input.characters)
                for(var i = 0; i < 4; i++) {
                    for(var j = 0; j < 4; j++) {
                        if let num = Int(String(guess[i])) {
                            if(num == ans[j]) {
                                if(i == j) {
                                    A++
                                }
                                else {
                                    B++
                                }
                            }
                        }
                    }
                }
                if(A == 4) {
                    guessResult.hidden = false
                    guessResult.text = "Congratulations, you win! Press Reset to play again"
                    Judge.hidden = false
                    Judge.text = "\(A)A\(B)B                    \(guess[0])\(guess[1])\(guess[2])\(guess[3])"
                    isOver = true
                }
                else if(guessTime < 10) {
                    guessResult.hidden = false
                    guessResult.text = "Not right,\(maxTime-guessTime) chances remaining"
                    Judge.hidden = false
                    Judge.text = "\(A)A\(B)B                    \(guess[0])\(guess[1])\(guess[2])\(guess[3])"
                    A = 0
                    B = 0
                }
                else {
                    guessResult.hidden = false
                    guessResult.text = "Sorry, you lose! Press Reset to play again"
                    isOver = true
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        inputNumber.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prefersStatusBarHidden() -> Bool {
        // eliminate time status, etc.
        return true
    }
    
    func distinctNumber()->[Int] {
        var ans = [0,0,0,0]
        var ans1 = Int(arc4random_uniform(10))
        var ans2 = Int(arc4random_uniform(10))
        var ans3 = Int(arc4random_uniform(10))
        var ans4 = Int(arc4random_uniform(10))
        while(ans1==ans2 || ans1==ans3 || ans1==ans4 || ans2==ans3 || ans2==ans4 || ans3==ans4) {
            ans1 = Int(arc4random_uniform(10))
            ans2 = Int(arc4random_uniform(10))
            ans3 = Int(arc4random_uniform(10))
            ans4 = Int(arc4random_uniform(10))
        }
        ans = [ans1,ans2,ans3,ans4]
        return ans
    }



}

