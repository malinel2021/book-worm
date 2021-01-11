//
//  SignUpViewController.swift
//  BookWorm
//
//  Created by Malin Leven on 4/12/2020.
//  Copyright © 2020 Malin Leven. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class SignUpViewController: UIViewController
{
    
    var myBool:Bool = false
    
    var currentUser: User!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
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
        Utilities.circularButton(button: signUpButton)
    }
    
    //Function to check if log in button should perform segue to home screen
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool
    {
        if identifier == "segue2"
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

    
    /*  Check the text fields and validate that the data is correct. If
        everything is correct it will return nil, if not it will display
        the error message
     */
    func validateFields() -> String?
    {
        //Check that all fields are filled in
        if usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            return "Please fill in all fields."
        }
        
        //Check if password is secure
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(password: cleanedPassword) == false
        {
            //Password is not secure enough
            return "Please make sure your password has at least 8 characters, contains a special character and a number."
        }
        
        let cleanedEmail = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isEmailValid(email: cleanedEmail) == false
        {
            //If email does not belong to school domain
            return "Please make sure you are using your CIS email."
        }

        return nil
    }
    
    @IBAction func signupButtonTapped(_ sender: Any)
    {
        //Validate the fields
        let error = validateFields()
        
        if error != nil
        {
            //There is something wrong with the text fields, display corresponding error message
            showError(message: error!)
            self.myBool = false
        }
        else
        {
            //Create cleaned versions of the data
            let username = usernameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //Create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                //Check for errors
                if err != nil
                {
                    //There was an error creating the user
                    self.showError(message: "Error creating user")
                }
                else
                {
                    //User was created successfully, now store username
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["username": username, "uid": result!.user.uid]) { (error) in
                        if error != nil
                        {
                            //Show error message
                            self.showError(message: "Error saving user data")
                        }
                    }
                }
            }
            //Performing segue
            self.currentUser = User(username: email)
            self.performSegue(withIdentifier: "segue2", sender: (Any).self)
        }
    }
    
    //Sending information to the post view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let barViewControllers = segue.destination as? UITabBarController
        {
            let destinationViewController = barViewControllers.viewControllers?[3] as! MyProfileViewController
            destinationViewController.currentUser = currentUser.getUsername()
        }
    }
    
    //Function to show error
    func showError(  message: String)
    {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
}
