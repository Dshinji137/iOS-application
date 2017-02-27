//
//  SettingNumberViewController.swift
//  QuickDial
//
//  Created by Hengzhi Ding on 17/2/22.
//  Copyright © 2017年 Hengzhi Ding. All rights reserved.
//

import UIKit

class SettingNumberViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var numberInput: UITextField!
    
    @IBAction func backSettingName(sender: UIButton) {
        let vc = self.navigationController?.childViewControllers[1]
        self.navigationController?.popToViewController(vc!, animated: true)
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = colorArray[selectNumber]
        numberInput.becomeFirstResponder()
        numberInput.returnKeyType = UIReturnKeyType.Done
        // if not nil, present original version
        if settingPhone != nil {
            numberInput.text = settingPhone
        }
    }
    
    // after press "return", to main menu
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // no input
        if numberInput.text == "" {
            let myAlert = UIAlertController(title: "Ooops", message: "Please enter a phone number", preferredStyle: .Alert)
            let action = UIAlertAction(title: "Done", style: .Default, handler: nil)
            myAlert.addAction(action)
            self.presentViewController(myAlert, animated: true, completion: nil)
        }
        else {
            settingPhone = numberInput.text!
            nameArray[selectNumber] = settingName!
            phoneArray[selectNumber] = settingPhone!
            
            // save
            NSUserDefaults.standardUserDefaults().setObject(nameArray, forKey: "contactName")
            NSUserDefaults.standardUserDefaults().setObject(phoneArray, forKey: "contactPhone")
            isSetting = false
            settingName = nil
            settingPhone = nil
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
        return true
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
}
