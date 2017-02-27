//
//  ChooseDeleteViewController.swift
//  QuickDial
//
//  Created by Hengzhi Ding on 17/2/22.
//  Copyright © 2017年 Hengzhi Ding. All rights reserved.
//

import UIKit

class ChooseDeleteViewController: UIViewController {
    @IBAction func backMenu(sender: UIButton) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    @IBAction func deleteEntry(sender: UIButton) {
        nameArray[selectNumber] = ""
        phoneArray[selectNumber] = ""
        // save
        NSUserDefaults.standardUserDefaults().setObject(nameArray, forKey: "contactName")
        NSUserDefaults.standardUserDefaults().setObject(phoneArray, forKey: "contactPhone")
        settingName = nil
        settingPhone = nil
        self.navigationController?.popToRootViewControllerAnimated(true)
        
    }
    
    
    @IBAction func editEntry(sender: UIButton) {
        settingName = nameArray[selectNumber]
        settingPhone = phoneArray[selectNumber]
        self.performSegueWithIdentifier("edit", sender: nil)
        
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = colorArray[selectNumber]
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}
