//
//  SecondViewController.swift
//  ToDoList
//
//  Created by Hengzhi Ding on 17/3/18.
//  Copyright © 2017年 Hengzhi Ding. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var myTextField: UITextField!
    
    @IBAction func changeText(sender: UITextField) {
        
        if myTextField.text == "" {
            addButton.setTitle("Back",forState: .Normal)
            addButton.setTitle("Back",forState: .Selected)
        }
        else {
            addButton.setTitle("Add",forState: .Normal)
            addButton.setTitle("Add",forState: .Selected)
        }
        
    }
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBAction func addTask(sender: UIButton) {
        
        if myTextField.text != "" {
            // store
            tasks.append(myTextField.text!)
            NSUserDefaults.standardUserDefaults().setObject(tasks, forKey: "Tasks")
            
        }
        myTextField.text = ""
        // keyboard disappear
        myTextField.resignFirstResponder()
        
        // back to first page (LIST)
        self.tabBarController?.selectedIndex = 0
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func viewWillAppear(animated: Bool) {
        myTextField.becomeFirstResponder()
        addButton.setTitle("Back",forState: .Normal)
        addButton.setTitle("Back",forState: .Selected)
    }
    
    // "Return" key to realize the same function as pressing "add" button
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if myTextField.text != "" {
            
            tasks.append(myTextField.text!)
            NSUserDefaults.standardUserDefaults().setObject(tasks, forKey: "Tasks")
            
            myTextField.text = ""
            // keyboard disappear
            myTextField.resignFirstResponder()
            // back to first page (LIST)
            self.tabBarController?.selectedIndex = 0
        }
        
        return true
    }
    
    


}

