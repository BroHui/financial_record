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
    var day: Int?
    var earned: Int?
    
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
        
        // 计算收益天数
        var earnedDays = round(endDate.timeIntervalSinceDate(startDate) / (3600 * 24))
        if earnedDays < 0 {
            earnedDays = 0
        }
//        print("earnedDays: \(earnedDays)")
        self.day = Int(earnedDays)
        
        // 计算收益金额
        let earned = Float(money)! * (Float(rate)! / 100) / 365 * Float(self.day!)
        self.earned = Int(earned)
    }

}
