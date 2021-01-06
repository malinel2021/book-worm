//
//  HomeViewController.swift
//  BookWorm
//
//  Created by Malin Leven on 4/12/2020.
//  Copyright © 2020 Malin Leven. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    @IBOutlet weak var homeLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        
        //Setting up elements on the view
        setUpElements()
    }
         
     
    func setUpElements()
    {
        var allPosts = [String]()
        var posts = ""
        let db = Firestore.firestore()
        db.collection("messages").getDocuments{ (QuerySnapshot, Error) in
            let err = Error
            if err != nil{
                print("Error getting documents: \(err)")
            }
            else
            {
                for document in QuerySnapshot!.documents {
                    posts = ("\(document.documentID) => \(document.data())")
                    allPosts.append(posts)
                }
                self.homeLabel.text = allPosts.joined()
//                print("Here is posts:", posts)
//                print("Here is the all posts array:", allPosts)
            }
            
        }
        

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

}
