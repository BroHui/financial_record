//
//  addFinancialTableViewController.swift
//  financial_record
//
//  Created by neil on 16/1/24.
//  Copyright © 2016年 com.brohui. All rights reserved.
//

import UIKit


class addFinancialTableViewController: UITableViewController {
    
    // MARK: Properties

    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePciker: UIDatePicker!
    @IBOutlet weak var endDateLabel: UILabel!
    
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
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
    
    

}