//
//  addFinancialTableViewController.swift
//  financial_record
//
//  Created by neil on 16/1/24.
//  Copyright © 2016年 com.brohui. All rights reserved.
//

import UIKit


class addFinancialTableViewController: UITableViewController, UITextFieldDelegate {

    // MARK: Properties

    @IBOutlet weak var financialNameText: UITextField!
    @IBOutlet weak var rateText: UITextField!
    @IBOutlet weak var moneyText: UITextField!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePciker: UIDatePicker!
    @IBOutlet weak var endDateLabel: UILabel!
    
    weak var myfin: Finanical?
    
    var startdatePickerHidden = true
    var endDatePickerHidden = true
    
    // MARK: - Static value
    enum sectionName: Int {
        case BASIC = 0, DATE
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        financialNameText.delegate = self
        rateText.delegate = self
        moneyText.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let sectionIndex = Int(section.value)
        if sectionIndex == sectionName.BASIC.rawValue {
            return 3
        } else if sectionIndex == sectionName.DATE.rawValue {
            return 4
        } else {
            return 0
        }
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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == sectionName.DATE.rawValue {
            if indexPath.row == 0 {
                startToggleDatePicker()
            } else if indexPath.row == 2 {
                endToggleDatePicker()
            }
        }
        
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        print("indexpath: \(indexPath.row)")
        if startdatePickerHidden && indexPath.section == sectionName.DATE.rawValue && indexPath.row == 1 {
            return 0
        } else if endDatePickerHidden && indexPath.section == sectionName.DATE.rawValue && indexPath.row == 3 {
            return 0
        } else {
            return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        }
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
        
        let financialName = financialNameText.text
        let rate = rateText.text
        let money = moneyText.text
        let startDate = startDatePicker.date
        let endDate = endDatePciker.date
        
        // 验证输入完整性
        if financialName == "" || rate == "" || money == "" {
            showMeTheAlert("请填写完所有数据后再保存")
        }
        
        print("Finanical: \(financialName), \(rate), \(money), \(startDate), \(endDate)")
       
//        self.myfin = Finanical(name: financialName, rate: <#T##String#>, money: <#T##String#>, startDate: <#T##NSDate#>, endDate: <#T##NSDate#>)
        
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldDidEndEditing(textField: UITextField) {
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // 隐藏键盘
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - DatetimePicker
    func startToggleDatePicker() {
        startdatePickerHidden = !startdatePickerHidden
        startDatePicker.hidden = startdatePickerHidden
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func endToggleDatePicker() {
        endDatePickerHidden = !endDatePickerHidden
        endDatePciker.hidden = endDatePickerHidden
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func startDatePickerChanged() {
        // 选择的日期显示在Detail样式上
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let pickDate = dateFormatter.stringFromDate(startDatePicker.date)
        startDateLabel.text = pickDate
    }
    
    func endDatePickerChanged() {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let pickDate = dateFormatter.stringFromDate(endDatePciker.date)
        endDateLabel.text = pickDate
    }
    
    @IBAction func startDatePickeValue(sender: UIDatePicker) {
        startDatePickerChanged()
    }
    
    @IBAction func endDatePickeValue(sender: UIDatePicker) {
        endDatePickerChanged()
    }
    
    // MARK: - Action
    
//    @IBAction func newFinancialSave(sender: UIBarButtonItem) {
//        let financialName = financialNameText.text
//        let rate = rateText.text
//        let money = moneyText.text
//        let startDate = startDatePicker.date
//        let endDate = endDatePciker.date
//        
//        // 验证输入完整性
//        if financialName == "" || rate == "" || money == "" {
//            showMeTheAlert("请填写完所有数据后再保存")
//            return
//        }
//        
//        print("Finanical: \(financialName), \(rate), \(money), \(startDate), \(endDate)")
//        
//        let db = FMDatabase(path: appDelegate.databasePath)
//        if !db.open() {
//            showMeTheAlert("无法打开数据库")
//            return
//        }
//        
//        do {
//            let insertSQL = "INSERT INTO \(appDelegate.TABLE_NAME) (name, rate, money, startDate, endDate) VALUES(?, ?, ?, ?, ?)"
//            try db.executeUpdate(insertSQL, values: [financialName!, rate!, money!, startDate, endDate])
//            showMeTheAlert("插入数据库成功")
//            
//        } catch let error as NSError {
//            print("failed: \(error.localizedDescription)")
//            showMeTheAlert("插入数据库失败")
//        }
//        
//        db.close()
//        
//    }
    
    // MARK: Alertview
    func showMeTheAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    // MARK: Segue
    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    

}
