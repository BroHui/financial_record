//
//  Finanical.swift
//  financial_record
//
//  Created by MacMini-1 on 16/1/27.
//  Copyright © 2016年 com.brohui. All rights reserved.
//

import UIKit

class Finanical: NSObject {
    
    var name: String?
    var rate: String?
    var money: String?
    var startDate: NSDate
    var endDate: NSDate
    
    init?(name: String, rate: String, money: String, startDate: NSDate, endDate: NSDate) {
        self.name = name
        self.rate = rate
        self.money = money
        
        self.startDate = startDate
        self.endDate = endDate
        
        super.init()
        
        if name.isEmpty || rate.isEmpty || money.isEmpty {
            return nil
        }
    }

}
