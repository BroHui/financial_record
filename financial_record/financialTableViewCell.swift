//
//  financialTableViewCell.swift
//  financial_record
//
//  Created by MacMini-1 on 16/1/22.
//  Copyright © 2016年 com.brohui. All rights reserved.
//

import UIKit

class financialTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet weak var financialRateLabel: UILabel!
    @IBOutlet weak var financialNameLabel: UILabel!
    @IBOutlet weak var totalMoney: UILabel!
    @IBOutlet weak var endDay: UILabel!
    @IBOutlet weak var endEarnMoney: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
