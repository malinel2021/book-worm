//
//  Utilities.swift
//  BookWorm
//
//  Created by Malin Leven on 8/12/2020.
//  Copyright © 2020 Malin Leven. All rights reserved.
//

import Foundation
import UIKit

class Utilities
{
    static func circularButton(button: UIButton)
    {
        button.layer.cornerRadius = 30.0
    }
    
/*
    Method to check password is valid
    Password must have at least:
    1. Length of 8
    2. One letter
    3. One Special Character
     
    Regex generated using https://iosdevcenters.blogspot.com/2017/06/password-validation-in-swift-30.html
*/
    static func isPasswordValid( password : String) -> Bool
    {
        let passwordPattern = "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordPattern)
        return passwordTest.evaluate(with: password)
    }
    
/*
     Method to check if email is valid
     Email must belong to either following domain:
     1. @student.cis.edu.hk
     2. @cis.edu.hk
     
     Regex generated using https://regex101.com/r/zxRmPq/1 and https://stackoverflow.com/questions/4323167/regular-expression-for-email-to-allow-only-two-domain
*/
    static func isEmailValid( email : String) -> Bool
    {
        let emailPattern = #"\b[A-Z0-9a-z._%+-]*@(student\.cis\.edu\.hk|cis\.edu\.hk)\b"#
        let emailTest = NSPredicate (format: "SELF MATCHES %@", emailPattern)
        return emailTest.evaluate(with: email)
    }
}
