//
//  HomeViewController.swift
//  BookWorm
//
//  Created by Malin Leven on 4/12/2020.
//  Copyright © 2020 Malin Leven. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
         super.viewDidLoad()
         
         //Setting up elements on the view
         setUpElements()

     }
     
     func setUpElements(){
    }
         
        // Do any additional setup after loading the view.
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func transitionToProfile()
    {
        let profileViewController = storyboard?.instantiateViewController(identifier: Constants.StoryBoard.profileViewController) as? ProfileViewController
        
        view.window?.rootViewController = profileViewController
        view.window?.makeKeyAndVisible()
    }

}
