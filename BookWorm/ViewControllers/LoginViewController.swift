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
    @IBOutlet weak var emailTextField: UITextField!
        
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    //Initialising boolean to signify if segue should perform
    private var myBool:Bool = false
    
    //Creating a User instance for the current user
    var currentUser: User!
        
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //Setting up elements on the view
        setUpElements()
    }
    
    func setUpElements()
    {
        //Hiding the error label
        errorLabel.alpha = 0
                
       //Changing aesthetics of the button
        Utilities.circularButton(button: loginButton)
    }
    
    //Function to check if log in button should perform segue to home screen
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool
    {
        if identifier == Constants.SEGUE_1
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

    //Try to log user in if the login button is tapped
    @IBAction func loginButtonTapped(_ sender: Any)
    {
        //Create cleaned versions of the text fields
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)        
        
        //Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            //Checking for errors
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
                self.currentUser = User(username: email)
                self.performSegue(withIdentifier: Constants.SEGUE_1, sender: (Any).self)
            }
        }
    }
    
    //Sending the information about the current user across to the other view controllers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let barViewControllers = segue.destination as? UITabBarController
        {
            let destinationViewController = barViewControllers.viewControllers?[3] as! MyProfileViewController
            destinationViewController.currentUser = currentUser.getUsername()
        }
        if let barViewControllers = segue.destination as? UITabBarController
        {
            let destinationViewController = barViewControllers.viewControllers?[2] as! PostViewController
            destinationViewController.postAuthorUsername = currentUser.getUsername()
        }
    }
}

