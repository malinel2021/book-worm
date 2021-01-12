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
    //Function to format a circular button
    static func circularButton(button: UIButton)
    {
        button.layer.cornerRadius = 30.0
    }
    
    //Function to format rounded text views
    static func roundedText(textView: UITextView)
    {
        textView.layer.cornerRadius = 10.0
    }
    
    //Function to format rounded table views
    static func formatTable(tableView: UITableViewCell)
    {
        tableView.layer.borderWidth = 0.5
        tableView.layer.cornerRadius = 10
    }
    
    //Function to get the current time as a string
    static func getTimeString() -> String
    {
        let currentDate = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let now = df.string(from:currentDate)
        return now
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
