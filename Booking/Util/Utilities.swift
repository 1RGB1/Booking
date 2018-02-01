//
//  Utilities.swift
//  Booking
//
//  Created by Ahmad Ragab on 1/1/18.
//  Copyright © 2018 Ahmad Ragab. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    
    class func isValidInput(_ input: String, withRegex regex: String) -> Bool {
        let Test = NSPredicate(format:"SELF MATCHES %@", regex)
        return Test.evaluate(with:input)
    }
    
    class func showAlertWithTitle(_ title: String, withMessage message: String) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alertController.addAction(okAction)
        return alertController
    }
    
    // Check Login API, Why it doesn't return the right data
    class func saveAndDeleteUser(model: UserModel?) {
        let defaults = UserDefaults.standard
        
        if model == nil {
            defaults.set(-1, forKey: "UserId")
        } else {
            defaults.set(Int(model!.id!), forKey: "UserId")
        }
        
        //defaults.set(1, forKey: "UserId")
        defaults.synchronize()
    }
    
    // Check Login API, Why it doesn't return the right data
    class func getSavedUserId() -> Int {
        return UserDefaults.standard.object(forKey: "UserId") as! Int
        //return 1
    }
}
