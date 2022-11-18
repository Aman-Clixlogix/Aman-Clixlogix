//
//  Alert.swift
//  Aylo
//
//  Created by Manas Mital.
//  Copyright © 2020 Clixlogix Technologies. All rights reserved.
//

import UIKit
import AVFoundation
import SystemConfiguration
import Foundation
import RealmSwift

class Alert: NSObject {
    // MARK: Get Hex String From UIcolor
    class func hexFromUIColor(color: UIColor) -> String {
        
        let hexString = String(format: "%02X%02X%02X",
                               Int((color.cgColor.components?[0])! * 255.0),
                               Int((color.cgColor.components?[1])! * 255.0),
                               Int((color.cgColor.components?[2])! * 255.0))
        return hexString
    }
    
    // MARK: Get UIcolor From Hex String
    class func colorFromHexString(hexCode: String!) -> UIColor {
        var cString: String = hexCode.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    // MARK: - convert Array to json object string
    class func jsonStringWithJSONObjectFromArray(array: NSArray) -> NSString {
        let data: NSData? = try? JSONSerialization.data(withJSONObject: array, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData
        var jsonStr: NSString?
        if data != nil {
            jsonStr = String(data: data! as Data, encoding: String.Encoding.utf8) as NSString?
        }
        return jsonStr!
    }
    
    // MARK: - convert dictionary to json object string
    class func jsonStringWithJSONObject(dictionary: NSDictionary) -> NSString {
        let data: NSData? = try? JSONSerialization.data(withJSONObject: dictionary, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData
        var jsonStr: NSString?
        if data != nil {
            jsonStr = String(data: data! as Data, encoding: String.Encoding.utf8) as NSString?
        }
        return jsonStr!
    }
    // MARK: - SET CUSTOM IMAGE IN UIBG
    class func isNull(someObject: AnyObject?) -> Bool {
        guard let someObject = someObject else {
            return true
        }
        return (someObject is NSNull)
    }
    
    class func showAlert(alerttitle: String, alertmessage: String, ButtonTitle: String, viewController: UIViewController) {
        let alertController = UIAlertController(title: alerttitle, message: alertmessage, preferredStyle: .alert)
        let okButtonOnAlertAction = UIAlertAction(title: ButtonTitle, style: .default) { (action) -> Void in
        }
        alertController.addAction(okButtonOnAlertAction)
        alertController.show(alertController, sender: self)
    }
 
//    class func logoutSession() {
//        let realm = try! Realm()
//        let result = realm.objects(UserTable.self)
//        try! realm.write {
//                realm.delete(result)
//        }
//        let rootController = LandingPage()
//        UserDefaults.standard.removeObject(forKey: "connectedPeripheral")
//        UserDefaults.standard.removeObject(forKey: "connectedDeviceName")
//        SceneDelegate.shared?.switchRootViewControllerMain(rootViewController: rootController, animated: true, completion: nil)
//    }
    
}

