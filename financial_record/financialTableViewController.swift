//
//  financialTableViewController.swift
//  financial_record
//
//  Created by MacMini-1 on 16/1/22.
//  Copyright © 2016年 com.brohui. All rights reserved.
//

import UIKit
import FMDB

class financialTableViewController: UITableViewController {
    
    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    // MARK: 属性
    var fins = [Finanical]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        // 预加载数据库中的数据渲染tableview
        loadDataFromDatabase()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fins.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("financialCell", forIndexPath: indexPath) as! financialTableViewCell
        
        // Configure the cell...
        let thisFin = fins[indexPath.row]
        let thousandMoney = Int(thisFin.money!)! / 1000
        cell.nameLabel.text = thisFin.name
        cell.rateLabel.text = "\(thisFin.rate!)%"
        cell.moneyLabel.text = "\(thousandMoney)K"
        cell.earndLabel.text = "0"

        return cell
    }

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
    
    // MARK: 预加载
    func loadDataFromDatabase() {
        let db = FMDatabase(path: appDelegate.databasePath)
        if !db.open() {
            showMeTheAlert("无法打开数据库")
            return
        }
        
        do {
            let querySQL = "SELECT * FROM \(appDelegate.TABLE_NAME)"
            let rs = try db.executeQuery(querySQL, values: nil)
            
            while rs.next() {
//                let id = rs.intForColumn("id")
                let name = rs.stringForColumn("name")
                let rate = rs.stringForColumn("rate")
                let money = rs.stringForColumn("money")
                let startDate = rs.dateForColumn("startDate")
                let endDate = rs.dateForColumn("endDate")
                print("Finanical: \(name), \(rate), \(money), \(startDate), \(endDate)")
                let fin = Finanical(name: name!, rate: rate!, money: money!, startDate: startDate, endDate: endDate)!
                fins.append(fin)
            }
            
        } catch let error as NSError {
            print("failed: \(error.localizedDescription)")
        }
        
        db.close()
    }
    
    // MARK: Segue
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? addFinancialTableViewController, myfin = sourceViewController.myfin {
           
            // 插入数据库
            let db = FMDatabase(path: appDelegate.databasePath)
            if !db.open() {
                showMeTheAlert("无法打开数据库")
                return
            }
    
            do {
                let insertSQL = "INSERT INTO \(appDelegate.TABLE_NAME) (name, rate, money, startDate, endDate) VALUES(?, ?, ?, ?, ?)"
                try db.executeUpdate(insertSQL, values: [myfin.name!, myfin.rate!, myfin.money!, myfin.startDate, myfin.endDate])
    
            } catch let error as NSError {
                print("failed: \(error.localizedDescription)")
                showMeTheAlert("插入数据库失败")
            }
            
            db.close()
            
            // 插入tableview
            let newIndexPath = NSIndexPath(forRow: fins.count, inSection: 0)
            fins.append(myfin)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
        }
    }
    
    // MARK: Alertview
    func showMeTheAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }

}
