//
//  finDetailTableViewController.swift
//  financial_record
//
//  Created by neil on 16/1/29.
//  Copyright © 2016年 com.brohui. All rights reserved.
//

import UIKit

class finDetailTableViewController: UITableViewController {
    
    var myfin: Finanical?
    
    // MARK: Properties
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var earnLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var earn2Label: UILabel!
    @IBOutlet weak var rateTextView: UITextView!
    @IBOutlet weak var progressView: UIProgressView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // 隐藏第一块的section
        let frame = CGRectMake(0, 0, 0, 0.1);
        self.tableView.tableHeaderView = UIView(frame: frame)
        
        // 隐藏nav的底部黑线
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarPosition: .Any, barMetrics: .Default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
       
        // 加载数据
        nameLabel.text = myfin?.name
        moneyLabel.text = myfin?.money
        earnLabel.text = String(myfin!.earned!)
        earn2Label.text = String(myfin!.earned!)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let startDate = dateFormatter.stringFromDate(myfin!.startDate)
        startDateLabel.text = startDate
        let endDate = dateFormatter.stringFromDate(myfin!.endDate)
        endDateLabel.text = endDate
      
        let today = NSDate()
        let sinceStartDateDays = round(today.timeIntervalSinceDate(myfin!.startDate) / (3600 * 24))
        dayLabel.text = String(format: "%.0f", arguments: [sinceStartDateDays])
       
        let rateString = String(format: rateTextView.text, arguments: [myfin!.rate!])
        rateTextView.text = rateString
      
        // 设置进度条
        let progressRate = Float(sinceStartDateDays) / Float(myfin!.day!)
        progressView.setProgress(progressRate, animated: false)
        
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
        if section == 0 {
            return 3
        } else if section == 1 {
            return 2
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

}
