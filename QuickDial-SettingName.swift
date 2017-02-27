//
//  SettingNameViewController.swift
//  QuickDial
//
//  Created by Hengzhi Ding on 17/2/22.
//  Copyright © 2017年 Hengzhi Ding. All rights reserved.
//

import UIKit

class SettingNameViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameInput: UITextField!
    
    @IBAction func backMenu(sender: UIButton) {
        // back to main
        if settingName != nil {
            settingName = nil
            settingPhone = nil
        }
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    override func viewDidLoad() {
        // set the background the same as button
        self.view.backgroundColor = colorArray[selectNumber]
        
        // no auto correction
        nameInput.autocorrectionType = UITextAutocorrectionType.No
        // return become next
        nameInput.returnKeyType = UIReturnKeyType.Next
        nameInput.becomeFirstResponder()
        isSetting = true
        
        // if not nil, present original version
        if settingName != nil {
            nameInput.text = settingName
        }
    }
    
    // action when pressing "return" key
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // no input
        if nameInput.text == "" {
            let myAlert = UIAlertController(title: "Ooops", message: "Please enter a contact name", preferredStyle: .Alert)
            let action = UIAlertAction(title: "Done", style: .Default, handler: nil)
            myAlert.addAction(action)
            self.presentViewController(myAlert, animated: true, completion: nil)
        }
        else {
            settingName = nameInput.text
            self.performSegueWithIdentifier("showSettingNumber", sender: nil)
        }
        return true
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}
