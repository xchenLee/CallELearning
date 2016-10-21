//
//  Lead.swift
//  iLucky
//
//  Created by renren on 16/10/10.
//  Copyright © 2016年 com.lee.lucky. All rights reserved.
//

import UIKit
import Foundation

public class Lead: NSObject, NSCoding {
    
    public let phone: String!
    public let label: String!
    
    public init(title: String, label: String) {
        self.phone = title
        self.label = label
    }
    
    required public init?(coder aDecoder: NSCoder) {
        self.phone = aDecoder.decodeObject(forKey: "phone") as? String ?? ""
        self.label = aDecoder.decodeObject(forKey: "label") as? String ?? ""
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.phone, forKey: "phone")
        aCoder.encode(self.label, forKey: "label")
    }

}
