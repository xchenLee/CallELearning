//
//  CallDirectoryHandler.swift
//  iCallExt
//
//  Created by renren on 16/9/27.
//  Copyright © 2016年 com.lee.lucky. All rights reserved.
//

import Foundation
import CallKit
import SharedClass

let kContainerUrlComponents = "numbers.plist"


class CallDirectoryHandler: CXCallDirectoryProvider {

    override func beginRequest(with context: CXCallDirectoryExtensionContext) {
        context.delegate = self

        do {
            try addBlockingPhoneNumbers(to: context)
        } catch {
            NSLog("Unable to add blocking phone numbers")
            let error = NSError(domain: "CallDirectoryHandler", code: 1, userInfo: nil)
            context.cancelRequest(withError: error)
            return
        }

        do {
            try addIdentificationPhoneNumbers(to: context)
        } catch {
            NSLog("Unable to add identification phone numbers")
            let error = NSError(domain: "CallDirectoryHandler", code: 2, userInfo: nil)
            context.cancelRequest(withError: error)
            return
        }

        context.completeRequest()
    }

    private func addBlockingPhoneNumbers(to context: CXCallDirectoryExtensionContext) throws {
        // Retrieve phone numbers to block from data store. For optimal performance and memory usage when there are many phone numbers,
        // consider only loading a subset of numbers at a given time and using autorelease pool(s) to release objects allocated during each batch of numbers which are loaded.
        //
        // Numbers must be provided in numerically ascending order.
        let phoneNumbers: [CXCallDirectoryPhoneNumber] = [ 14085555555, 18005555555 ]

        for phoneNumber in phoneNumbers {
            context.addBlockingEntry(withNextSequentialPhoneNumber: phoneNumber)
        }
    }

    private func addIdentificationPhoneNumbers(to context: CXCallDirectoryExtensionContext) throws {
        // Retrieve phone numbers to identify and their identification labels from data store. For optimal performance and memory usage when there are many phone numbers,
        // consider only loading a subset of numbers at a given time and using autorelease pool(s) to release objects allocated during each batch of numbers which are loaded.
        //
        // Numbers must be provided in numerically ascending order.
//        let phoneNumbers: [CXCallDirectoryPhoneNumber] = [ +8618513542169, +8618610812492 ]
//        let labels = [ "Telemarketerdddddddddddsfsdfsdsf,,dsfasfdsadsdsfsdfaadfasdfa", "哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈啊哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈" ]
//
//        readDatasFromSharedArea()
//        for (phoneNumber, label) in zip(phoneNumbers, labels) {
//            context.addIdentificationEntry(withNextSequentialPhoneNumber: phoneNumber, label: label)
//        }
        
        
        var lead: Lead?
        var url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.lucky")
        url = url?.appendingPathComponent(kContainerUrlComponents)
        
        let path = url?.path
        
        let object = NSKeyedUnarchiver.unarchiveObject(withFile: path!)
        guard let safeArray = object as? Array<[String: String]> else {
            return
        }
        for dic in safeArray {
            
            if let number = dic["phone"] {
            
                context.addIdentificationEntry(withNextSequentialPhoneNumber: CXCallDirectoryPhoneNumber(number)!, label: "hahahahahaha")
                print("hahahahahahahahahhhahahahahahh")
            }
        }
    }

}

func readDatasFromSharedArea() {
    
    
}

extension CallDirectoryHandler: CXCallDirectoryExtensionContextDelegate {

    func requestFailed(for extensionContext: CXCallDirectoryExtensionContext, withError error: Error) {
        // An error occurred while adding blocking or identification entries, check the NSError for details.
        // For Call Directory error codes, see the CXErrorCodeCallDirectoryManagerError enum in <CallKit/CXError.h>.
        //
        // This may be used to store the error details in a location accessible by the extension's containing app, so that the
        // app may be notified about errors which occured while loading data even if the request to load data was initiated by
        // the user in Settings instead of via the app itself.
    }

}
