//
//  MyProfileViewController.swift
//  BookWorm
//
//  Created by Malin Leven on 10/1/2021.
//  Copyright © 2021 Malin Leven. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class MyProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var table: UITableView!
    
    var userPosts = [Post]()
    
    var currentUser: String!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        let userShort = currentUser.components(separatedBy: CharacterSet(charactersIn: ("@"))).first
        username.text = userShort! + "'s Book Reviews"
        table.register(ProfileTableViewCell.nib(), forCellReuseIdentifier: ProfileTableViewCell.identifier)
        table.delegate = self
        table.dataSource = self

        //Setting up elements on the view
        setUpElements()
    }
    
    func setUpElements()
    {
        var tempPosts = [Post]()
        let db = Firestore.firestore()
        db.collection("Test3").getDocuments{ (QuerySnapshot, Error) in
            let err = Error
            if err != nil
            {
                print("Error getting documents: \(err)")
            }
            else
            {
                for document in QuerySnapshot!.documents
                {
                    let postAuthor = document.get("Post Author") as! String
                    if postAuthor == self.currentUser
                    {
                        let title = document.get("Title")
                        let author = document.get("Author")
                        let blurb = document.get("Blurb")
                        let rating = document.get("Rating")
                        let review = document.get("Review")
                        let time = document.get("Date")
                                                
                        let post = Post(bookName: title as! String, postAuthor: postAuthor, bookAuthor: author as! String, blurb: blurb as! String, rating: rating as! Int, reviewString: review as! String, timeString: time as! String)
                        
                        tempPosts.insert(post, at: 0)
                    }
                }
                self.userPosts = tempPosts
                self.table.reloadData()
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        userPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier, for: indexPath) as! ProfileTableViewCell
        cell.configure(with: userPosts[indexPath.row])
        return cell
    }
}
