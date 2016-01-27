//
//  Finanical.swift
//  financial_record
//
//  Created by MacMini-1 on 16/1/27.
//  Copyright © 2016年 com.brohui. All rights reserved.
//

import UIKit

class Finanical: NSObject {
    
    let name: String?
    let rate: String?
    let money: String?
    let startDate: NSDate
    let endDate: NSDate
    
    init(name: String, rate: String, money: String, startDate: NSDate, endDate: NSDate) {
        self.name = name
        self.rate = rate
        self.money = money
        
        self.startDate = startDate
        self.endDate = endDate
    }

}
