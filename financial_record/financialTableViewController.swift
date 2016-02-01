//
//  financialTableViewController.swift
//  financial_record
//
//  Created by MacMini-1 on 16/1/22.
//  Copyright © 2016年 com.brohui. All rights reserved.
//

import UIKit
import FMDB
import LocalAuthentication

class financialTableViewController: UITableViewController {
    
    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    // MARK: 属性
    var fins = [Finanical]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        authenticateUser()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        self.navigationItem.leftBarButtonItem?.title = "编辑"
        
    }
    
    override func viewWillAppear(animated: Bool) {
        // 预加载数据库中的数据渲染tableview
        loadDataFromDatabase()
        tableView.reloadData()
    }
    
    // Tableview的编辑模式，navgition左侧按钮显示为中文
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if editing {
            self.editButtonItem().title = "完成"
        } else {
            self.editButtonItem().title = "编辑"
        }
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
        cell.nameLabel.text = thisFin.name
        cell.rateLabel.text = "\(thisFin.rate!)%"
        
        let money = String(format: "%.1f", Float(thisFin.money!)! / 10000)
        cell.moneyLabel.text = "\(money)万"
       
        let earned = String(format: "%.2f", Float(thisFin.earned!) / 10000)
        cell.earndLabel.text = "\(earned)万"

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            let theFin = fins[indexPath.row]
           
            // 从数据库删除
            let db = FMDatabase(path: appDelegate.databasePath)
            if !db.open() {
                showMeTheAlert("无法打开数据库")
                return
            }
            
            do {
//                print("Finanical: \(theFin.name), \(theFin.rate), \(theFin.money), \(theFin.startDate), \(theFin.endDate)")
                let deleteSQL = "DELETE FROM \(appDelegate.TABLE_NAME) WHERE name=? and rate=? and money=? and startDate=?"
                try db.executeUpdate(deleteSQL, values: [theFin.name!, theFin.rate!, theFin.money!, theFin.startDate])
            } catch let error as NSError {
                print("failed: \(error.localizedDescription)")
                showMeTheAlert("删除失败")
            }
            db.close()
            
            fins.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
   
    // tablview左滑显示删除文字
    override func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return "删除"
    }

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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "finDetailSegue" {
            let destVC = segue.destinationViewController as? finDetailTableViewController
            let indexPath = self.tableView.indexPathForSelectedRow!
            let selectFin = fins[indexPath.row]
            destVC?.myfin = selectFin
        }
    }
    
    // MARK: 预加载
    func loadDataFromDatabase() {
        let db = FMDatabase(path: appDelegate.databasePath)
        if !db.open() {
            showMeTheAlert("无法打开数据库")
            return
        }
       
        // 清空Modal
        fins.removeAll(keepCapacity: false)
        
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
                let insertSQL = "INSERT INTO \(appDelegate.TABLE_NAME) (name, rate, money, startDate, endDate, earned, days) VALUES(?, ?, ?, ?, ?, ?, ?)"
                try db.executeUpdate(insertSQL, values: [myfin.name!, myfin.rate!, myfin.money!, myfin.startDate, myfin.endDate, myfin.earned!, myfin.day!])
    
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
    
    // MARK: - Auth
    func authenticateUser() {
        let context = LAContext()
        var error: NSError?
        let reason = "请验证您的指纹"
        
        if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &error) {
            // 可以使用指纹的机器
            beBlur()
            
            context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: reason, reply: {
                (success: Bool, error: NSError?) in
                if success {
                    print("指纹验证成功")
                    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                        self.beNotBlur()
                    })
                } else {
                    print(error?.localizedDescription)
                    switch error?.code {
                    case LAError.SystemCancel.rawValue?:
                        print("切换到其他APP，系统取消验证Touch ID")
                    case LAError.UserCancel.rawValue?:
                        print("用户取消验证Touch ID")
                    case LAError.UserFallback.rawValue?:
                        print("用户选择输入密码，切换主线程处理")
                    case LAError.TouchIDLockout.rawValue?:
                        print("Touch ID输入错误多次，已被锁")
                    case LAError.AppCancel.rawValue?:
                        print("用户除外的APP挂起，如电话接入等切换到了其他APP")
                    default:
                        print("其他情况")
                    }
                }
            })
            
        } else {
            // 不支持指纹的机型，做其他处理
            print(error?.localizedDescription)
        }
        
    }
    
    func showPasswordAlert() {
        let passwordAlert = UIAlertController(title: "TouchID DEMO", message: "请输入密码", preferredStyle: .Alert)
        passwordAlert.addTextFieldWithConfigurationHandler({ (textField: UITextField) in
            textField.secureTextEntry = true
        })
        let cancelButton = UIAlertAction(title: "取消", style: .Cancel, handler: { (action: UIAlertAction) -> Void in
            print("user press cancel")
        })
        let okButton = UIAlertAction(title: "确定", style: .Default, handler: { (action: UIAlertAction) -> Void in
            let password = passwordAlert.textFields?.first?.text
            if let pw = password {
                print("user press ok, and passwrod is \(pw)")
            }
        })
        passwordAlert.addAction(cancelButton)
        passwordAlert.addAction(okButton)
        self.presentViewController(passwordAlert, animated: true, completion: nil)
    }
  
    
    // MARK: blur
    func beBlur() {
        // 模糊的毛玻璃效果
        let effe = UIVisualEffectView(effect: UIBlurEffect(style: .Light))
        effe.tag = 200
        effe.frame = self.view.bounds
        effe.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.view.addSubview(effe)
    }
  
    func beNotBlur() {
        // 移除毛玻璃效果
        for subview in self.view.subviews {
            if subview.tag == 200 {
                subview.removeFromSuperview()
            }
        }
    }
    
}
