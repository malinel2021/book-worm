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
    
    //Array to hold all of the current user's posts from Firestore
    var userPosts = [Post]()
    
    //Username for the current user
    var currentUser: String!

    override func viewWillAppear(_ animated: Bool)
    {
        super.viewDidLoad()
        
        //Setting the username label to the current user
        let userShort = currentUser.components(separatedBy: CharacterSet(charactersIn: (Constants.AT))).first
        username.text = Constants.AT + userShort!
        
        //Setting up the table with the type of table cell it will be using
        table.register(ProfileTableViewCell.nib(), forCellReuseIdentifier: ProfileTableViewCell.identifier)
        table.delegate = self
        table.dataSource = self

        //Setting up elements on the view
        setUpElements()
    }
    
    func setUpElements()
    {
        //Creating a temporary Array variable to hold posts
        var tempPosts = [Post]()
        
        //Getting the Firestore database documents
        let db = Firestore.firestore()
        db.collection(Constants.POSTS).getDocuments{ (QuerySnapshot, Error) in
            //Checking for errors
            let err = Error
            if err != nil
            {
                print("Error getting documents: \(err)")
            }
            else
            {
                //For loop to get data for each post and create a Post instance with the data if the post belongs to the current user
                for document in QuerySnapshot!.documents
                {
                    let postAuthor = document.get(Constants.POST_AUTHOR) as! String
                    //Checking if the author of the post is the current user
                    if postAuthor == self.currentUser
                    {
                        let title = document.get(Constants.TITLE)
                        let author = document.get(Constants.BOOK_AUTHOR)
                        let blurb = document.get(Constants.BLURB)
                        let rating = document.get(Constants.RATING)
                        let review = document.get(Constants.REVIEW)
                        let time = document.get(Constants.DATE)
                                 
                        let post = Post(bookName: title as! String, postAuthor: postAuthor, bookAuthor: author as! String, blurb: blurb as! String, rating: rating as! Int, reviewString: review as! String, timeString: time as! String)
                        
                        //Adding each post to the temporary Array, sorting by time with the newest post at the top
                        tempPosts.append(post)
                        tempPosts = tempPosts.sorted { $0.timeString > $1.timeString }
                    }
                }
                //Setting the array for the table and reloading
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
        return userPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier, for: indexPath) as! ProfileTableViewCell
        cell.configure(with: userPosts[indexPath.row])
        return cell
    }
}
