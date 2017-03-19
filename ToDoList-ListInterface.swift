//
//  FirstViewController.swift
//  ToDoList
//
//  Created by Hengzhi Ding on 17/3/18.
//  Copyright © 2017年 Hengzhi Ding. All rights reserved.
//

import UIKit

var tasks = [String]();

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var myTableView: UITableView!
    
    @IBOutlet weak var addTaskReminder: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if NSUserDefaults.standardUserDefaults().objectForKey("Tasks") != nil {
            tasks = NSUserDefaults.standardUserDefaults().objectForKey("Tasks") as! Array
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        // update tableview
        myTableView.reloadData()
        
        if tasks.count == 0 {
            addTaskReminder.hidden = false
        }
        else {
            addTaskReminder.hidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    // how many section to display
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // how many rows each section
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    // what to display
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = tasks[indexPath.row]
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.textLabel?.font = UIFont(name:"arial", size: 24)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        myTableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    // delete task
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            tasks.removeAtIndex(indexPath.row)
            NSUserDefaults.standardUserDefaults().setObject(tasks, forKey: "Tasks")
            myTableView.reloadData()
            
            if tasks.count == 0 {
                addTaskReminder.hidden = false
            }
            else {
                addTaskReminder.hidden = true
            }
        }
        
    }
    
    


}

