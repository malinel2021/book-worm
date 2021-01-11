//
//  HomeViewController.swift
//  BookWorm
//
//  Created by Malin Leven on 4/12/2020.
//  Copyright © 2020 Malin Leven. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet var table: UITableView!
    
    //Array to hold all the posts from Firestore
    var allPosts = [Post]()
    
    //Username of current user signed in. This String is sent by the sign up or the log in view controllers
    //using the segue
    var currentUser: String!
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewDidLoad()
        
        //Setting up the table with the type of table cell it will be using
        table.register(PostTableViewCell.nib(), forCellReuseIdentifier: PostTableViewCell.identifier)
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
        db.collection("Posts").getDocuments { (QuerySnapshot, Error) in
            //Checking for errors
            let err = Error
            if err != nil
            {
                print("Error getting documents: \(err)")
            }
            else
            {
                //For loop to get data for each post and create a Post instance with the data
                for document in QuerySnapshot!.documents
                {
                    let title = document.get("Title")
                    let postAuthor = document.get("Post Author")
                    let author = document.get("Author")
                    let blurb = document.get("Blurb")
                    let rating = document.get("Rating")
                    let review = document.get("Review")
                    let time = document.get("Date")
                    let post = Post(bookName: title as! String, postAuthor: postAuthor as! String, bookAuthor: author as! String, blurb: blurb as! String, rating: rating as! Int, reviewString: review as! String, timeString: time as! String)

                    //Adding each post to the temporary Array, sorting by time with the newest post at the top
                    tempPosts.append(post)
                    tempPosts = tempPosts.sorted { $0.timeString > $1.timeString }
                }
                //Setting the array for the table and reloading
                self.allPosts = tempPosts
                self.table.reloadData()
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return allPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as! PostTableViewCell
        cell.configure(with: allPosts[indexPath.row])
        return cell
    }
}
