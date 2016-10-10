//
//  TodayViewController.swift
//  iLuckyExt
//
//  Created by renren on 16/9/26.
//  Copyright © 2016年 com.lee.lucky. All rights reserved.
//

import UIKit
import NotificationCenter


class TodayViewController: UIViewController, NCWidgetProviding {
    
    var contentView: UIView!
        
    @IBOutlet weak var resetBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        self.preferredContentSize = CGSize(width: 0, height: 100)
        self.resetBtn.backgroundColor = UIColor.red
    }
    
    func widgetMarginInsets(forProposedMarginInsets defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func resizeBtnClicked(_ sender: AnyObject) {
        self.preferredContentSize = CGSize(width: 0, height: self.preferredContentSize.height > 100 ? 100 : 150)
    }
    
    
    @nonobjc func widgetPerformUpdate(completionHandler: ((NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
