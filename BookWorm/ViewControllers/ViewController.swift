//
//  ViewController.swift
//  BookWorm
//
//  Created by Malin Leven on 4/12/2020.
//  Copyright © 2020 Malin Leven. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController
{
    private var myBool:Bool = false
        
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var signUpButton: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpElements()
        
    }
    
    func setUpElements()
    {
        //Hiding the error label
        errorLabel.alpha = 0
                
       //Set up the utilities and stuff
        Utilities.circularButton(button: loginButton)
        
    }
    
    //Function to check if log in button should perform segue to home screen
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool
    {
        if identifier == "segue1"
        {
            //Checking if the log in worked
            if  myBool == false
            {
                //If log in was not successfull, segue to the home page will not be performed
                return false
            }
        }
        //If log in was successful, segue to the home page
        return true
    }

    @IBAction func loginButtonTapped(_ sender: Any)
    {
        //Create cleaned versions of the text fields
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        //Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil
            {
                //Couldn't sign in, showing error on the screen
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
                //Setting boolean variable to false so segue will not be performed
                self.myBool = false
            }
            else
            {
                //Performing segue
                self.performSegue(withIdentifier: "segue1", sender: (Any).self)
            }
        }
    }

}

