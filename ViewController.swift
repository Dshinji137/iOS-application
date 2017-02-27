//
//  ViewController.swift
//  QuickDial
//
//  Created by Hengzhi Ding on 17/2/22.
//  Copyright © 2017年 Hengzhi Ding. All rights reserved.
//

import UIKit

var colorArray:[UIColor]!
var selectNumber:Int = -1
var nameArray = ["","","","",""]
var phoneArray = ["","","","",""]
var isSetting = false
var settingName:String?
var settingPhone:String?

class ViewController: UIViewController {

    @IBOutlet weak var button1: BigLabelButton!
    @IBOutlet weak var button2: BigLabelButton!
    @IBOutlet weak var button3: BigLabelButton!
    @IBOutlet weak var button4: BigLabelButton!
    @IBOutlet weak var button5: BigLabelButton!
    
    var buttonArray:[BigLabelButton]!
    var viewWidth:CGFloat!
    var viewHeight:CGFloat!
    //var colorArray:[UIColor]!
    var colorPressArray:[UIColor]!
    
    // button Pressed, exert
    @IBAction func buttonTouched(sender: BigLabelButton) {
        // get which button pressed.
        let buttonNumber = sender.tag - 100
        buttonArray[buttonNumber].backgroundColor = colorPressArray[buttonNumber]
        buttonArray[buttonNumber].bigLabel.textColor = colorPressArray[5]
        
    }
    
    // button touch up inside, exert
    @IBAction func pressEnded(sender: BigLabelButton) {
        // get which button pressed.
        let buttonNumber = sender.tag - 100
        buttonArray[buttonNumber].backgroundColor = colorArray[buttonNumber]
        buttonArray[buttonNumber].bigLabel.textColor = colorArray[5]
        let thisName:String? = nameArray[buttonNumber]
        let thisNumber:String? = phoneArray[buttonNumber]
        // look if can dial
        if thisName != nil {
            if UIApplication.sharedApplication().canOpenURL(NSURL(string: "tel://\(thisNumber!)")!) == true {
                let url = NSURL(string: "tell://\(thisNumber!)")
                UIApplication.sharedApplication().openURL(url!)
                
            }
        }
        
    }
    // button touch up outside, exert (maybe to deal with wrong operation?)
    @IBAction func outsideEnded(sender: BigLabelButton) {
        // get which button pressed.
        let buttonNumber = sender.tag - 100
        buttonArray[buttonNumber].backgroundColor = colorArray[buttonNumber]
        buttonArray[buttonNumber].bigLabel.textColor = colorArray[5]
    }
    
    override func viewWillAppear(animated: Bool) {
        isSetting = false
        settingName = nil
        settingPhone = nil
        for var i = 0; i < buttonArray.count; i++ {
            buttonArray[i].backgroundColor = colorArray[i]
            buttonArray[i].bigLabel.textColor = colorArray[5]
        }
        
        var isEmpty = true
        for var i = 0; i < 5; i++ {
            if nameArray[i] != "" {
                isEmpty = false
            }
        }
        if isEmpty == true {
            for var i = 0; i < 5; i++ {
                buttonArray[i].bigLabel.text = ""
                buttonArray[i].bigLabel.hidden = true
            }
            buttonArray[1].bigLabel.text = "Long Press"
            buttonArray[1].bigLabel.hidden = false
        }
        else {
            for var i = 0; i < 5; i++ {
                if nameArray[i] != "" {
                    buttonArray[i].bigLabel.text = nameArray[i]
                    buttonArray[i].bigLabel.hidden = false
                }
                else {
                    buttonArray[i].bigLabel.hidden = true
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        viewWidth = view.frame.size.width
        viewHeight = view.frame.size.height
        buttonArray = [button1,button2,button3,button4,button5]
        for var i = 0; i < buttonArray.count; i++ {
            buttonArray[i].bigLabel.frame = CGRectMake(28, 0, viewWidth+100, viewHeight/5)
            buttonArray[i].bigLabel.font = UIFont(name:"Arial-Bold",size:80*(viewHeight/667))
            // add long press recognizer to each button
            // ":" means there are some parameters in function "LongPress"
            let longPress = UILongPressGestureRecognizer(target: self, action: Selector("LongPress:"))
            longPress.minimumPressDuration = 1.0
            buttonArray[i].addGestureRecognizer(longPress)
        }
        colorArray = [
            UIColor(red: 232/255,green: 88/255, blue: 32/255, alpha:1),
            UIColor(red: 250/255,green: 168/255, blue: 8/255, alpha:1),
            UIColor(red: 2/255,green: 160/255, blue: 131/255, alpha:1),
            UIColor(red: 9/255,green: 171/255, blue: 219/255, alpha:1),
            UIColor(red: 3/255,green: 127/255, blue: 208/255, alpha:1),
            UIColor.whiteColor()
        ]
        colorPressArray = [
            UIColor(red: 202/255,green: 38/255, blue: 1/255, alpha:1),
            UIColor(red: 220/255,green: 138/255, blue: 0/255, alpha:1),
            UIColor(red: 0/255,green: 130/255, blue: 101/255, alpha:1),
            UIColor(red: 0/255,green: 141/255, blue: 189/255, alpha:1),
            UIColor(red: 0/255,green: 97/255, blue: 178/255, alpha:1),
            UIColor.grayColor()
        ]
        
        if NSUserDefaults.standardUserDefaults().objectForKey("contactName") != nil {
            nameArray.removeAll(keepCapacity: true)
            nameArray = NSUserDefaults.standardUserDefaults().objectForKey("contactName") as! Array
        }
        if NSUserDefaults.standardUserDefaults().objectForKey("contactPhone") != nil {
            nameArray.removeAll(keepCapacity: true)
            phoneArray = NSUserDefaults.standardUserDefaults().objectForKey("contactPhone") as! Array
        }
    }
    
    func LongPress(sender: UILongPressGestureRecognizer) {
        if sender.state == .Began {
            selectNumber = sender.view!.tag - 100
            if nameArray[selectNumber] != "" {
                self.performSegueWithIdentifier("showChooseDelete", sender: nil)
            }
            else {
                self.performSegueWithIdentifier("showSettingName", sender: nil)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

class BigLabelButton: UIButton {
    let bigLabel = UILabel()
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        bigLabel.text = "Long Press"
        bigLabel.textColor = UIColor.whiteColor()
        bigLabel.shadowColor = UIColor.blackColor()
        self.addSubview(bigLabel)
    }
}

