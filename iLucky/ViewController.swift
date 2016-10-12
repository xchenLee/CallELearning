//
//  ViewController.swift
//  iLucky
//
//  Created by renren on 16/9/26.
//  Copyright © 2016年 com.lee.lucky. All rights reserved.
//

import UIKit
import CallKit
import NotificationCenter

let kContainerUrlComponents = "numbers.plist"

class ViewController: UIViewController {
    
    var animator: UIDynamicAnimator!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        animator = UIDynamicAnimator(referenceView: self.view)
        
        var url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.lucky")
        url = url?.appendingPathComponent(kContainerUrlComponents)
        
        guard let safeUrl = url else {
            return
        }
        
        let userDefaults = UserDefaults(suiteName: "group.lucky")
        userDefaults?.set("aaa", forKey: "aaa")
        userDefaults?.synchronize()
        
        let aaa = userDefaults?.object(forKey: "aaa")
        
        
        let path = safeUrl.path
        let phone:[String: String] = ["phone": "+8618610812492"]
        let array = [phone]
        NSKeyedArchiver.archiveRootObject(array, toFile: path)
        
        let object = NSKeyedUnarchiver.unarchiveObject(withFile: path)
        guard let safeArray = object as? Array<[String: String]> else {
            return
        }
        
        NCWidgetController.widgetController().setHasContent(true, forWidgetWithBundleIdentifier: "lee.iLucky.iLuckyExt")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

