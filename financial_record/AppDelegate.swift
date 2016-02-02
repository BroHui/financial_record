//
//  AppDelegate.swift
//  financial_record
//
//  Created by MacMini-1 on 16/1/22.
//  Copyright © 2016年 com.brohui. All rights reserved.
//

import UIKit
import FMDB

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    // 数据库路径
    var databasePath = String()


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        // 读取偏好设置，用户是否开启指纹锁功能
        let touchIDOpen = NSUserDefaults.standardUserDefaults().boolForKey("touchID")
        // 跳转指纹解锁view
        if touchIDOpen {
            let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
            let touchIDViewController = mainStoryBoard.instantiateViewControllerWithIdentifier("touchIDVC")
            self.window?.makeKeyAndVisible()
            self.window?.rootViewController?.presentViewController(touchIDViewController, animated: false, completion: nil)
        }
        
        // 设置全局导航栏样式
        let orangeColor = UIColor(colorLiteralRed: 255/255.0, green: 128/255.0, blue: 0/255.0, alpha: 1.0)
        UINavigationBar.appearance().barTintColor = orangeColor
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        let titleDict = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        UINavigationBar.appearance().titleTextAttributes = titleDict
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
       
        // 数据库初始化
        self.initDatabase()
        self.createDatabase()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // MARK: - FMDB
    let DATABASE_FILE_NAME = "financial.sqlite"
    let TABLE_NAME = "myfin"
    
    func initDatabase() -> Bool {
        let docPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first! as String
        let dbFile = "/" + DATABASE_FILE_NAME
        self.databasePath = docPath.stringByAppendingString(dbFile)
        print(self.databasePath)
        return true
    }
    
    func createDatabase() {
        let db = FMDatabase(path: databasePath)
        if !db.open() {
            print("无法打开数据库，请检查")
            return
        }
        
        do {
            let checkDBExisted = "SELECT * FROM '\(TABLE_NAME)' LIMIT 0,1"
            try db?.executeQuery(checkDBExisted, values: nil)
            print("database is already existed, skip")
            return
        } catch _ as NSError {
            print("create db")
        }
        
        do {
            let createSQL = "CREATE TABLE '\(TABLE_NAME)' ('id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, " +
                "'name' VARCHAR(20), 'rate' FLOAT(20), 'money' INTEGER, 'earned' FLOAT, 'startDate' VARCHAR(15), 'endDate' VARCHAR(15)," +
                " 'days' INTEGER)"
            try db?.executeUpdate(createSQL, values: nil)
            
        } catch let error as NSError {
            print("failed: \(error.localizedDescription)")
            print("创建数据库失败")
        }
        db.close()
    }
    
    func dropDatabase() {
        let db = FMDatabase(path: databasePath)
        if !db.open() {
            print("无法打开数据库，请检查")
            return
        }
        
        do {
            let dropSQL = "DROP TABLE '\(TABLE_NAME)'"
            try db?.executeUpdate(dropSQL, values: nil)
            
        } catch let error as NSError {
            print("failed: \(error.localizedDescription)")
            print("删除表失败")
        }
        db.close()
    }
}

