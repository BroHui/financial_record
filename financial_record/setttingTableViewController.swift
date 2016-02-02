//
//  setttingTableViewController.swift
//  financial_record
//
//  Created by MacMini-1 on 16/1/28.
//  Copyright © 2016年 com.brohui. All rights reserved.
//

import UIKit
import LocalAuthentication

class setttingTableViewController: UITableViewController {
    
    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    // MARK: propreties
    
    @IBOutlet weak var touchIDSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
       
        // 开关都恢复到配置状态
        let touchIDPreference = NSUserDefaults.standardUserDefaults().boolForKey("touchID")
        touchIDSwitch.setOn(touchIDPreference, animated: false)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    enum sectionName: Int {
        case SAFTY = 0, DATABASE, ABOUT
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let sectionIndex = Int(section.value)
        if sectionIndex == sectionName.DATABASE.rawValue{
            return 1
        } else if sectionIndex == sectionName.ABOUT.rawValue {
            return 1
        } else if sectionIndex == sectionName.SAFTY.rawValue {
            return 1
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == sectionName.DATABASE.rawValue {
            if indexPath.row == 0 {
                appDelegate.dropDatabase()
                appDelegate.createDatabase()
            }
        }
        
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
   
    // MARK: Actions
    
    @IBAction func touchIDToggle(sender: UISwitch) {
        
        let touchIDEnabled = touchIDSwitch.on
        
        if touchIDEnabled {
            // 指纹验证部分
            let context = LAContext()
            var error: NSError?
            let reason = "请验证您的指纹"
            
            if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &error) {
                // 可以使用指纹的机器
                
                context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: reason, reply: {
                    (success: Bool, error: NSError?) in
                    if success {
                        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                            NSUserDefaults.standardUserDefaults().setBool(touchIDEnabled, forKey: "touchID")
                        })
                    } else {
                        // 开启指纹遇到问题
                        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                            self.touchIDSwitch.setOn(false, animated: false)
                        })
                    }
                })
                
            } else {
                // 没有指纹功能，不允许开启
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.touchIDSwitch.setOn(false, animated: false)
                })
            }
        } else {
            // 关闭指纹验证功能
            NSUserDefaults.standardUserDefaults().setBool(touchIDEnabled, forKey: "touchID")
        }
    }
    
    

}
