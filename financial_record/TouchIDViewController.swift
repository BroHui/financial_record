//
//  TouchIDViewController.swift
//  financial_record
//
//  Created by MacMini-1 on 16/2/2.
//  Copyright © 2016年 com.brohui. All rights reserved.
//

import UIKit
import LocalAuthentication

class TouchIDViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        authenticateUser()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    // MARK: - Auth
    func authenticateUser() {
        print("hello")
        let context = LAContext()
        var error: NSError?
        let reason = "请验证您的指纹"
        
        if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &error) {
            // 可以使用指纹的机器
            
            context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: reason, reply: {
                (success: Bool, error: NSError?) in
                if success {
                    print("指纹验证成功")
                    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                        self.dismissViewControllerAnimated(true, completion: nil)
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
