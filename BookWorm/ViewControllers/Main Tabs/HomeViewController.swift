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
    
    var allPosts = [Post]()
    
    var currentUser: String!
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewDidLoad()
        table.register(PostTableViewCell.nib(), forCellReuseIdentifier: PostTableViewCell.identifier)
        table.delegate = self
        table.dataSource = self
        
        //Setting up elements on the view
        setUpElements()        
    }
         
     
    func setUpElements()
    {
        var tempPosts = [Post]()
        let db = Firestore.firestore()
        db.collection("Test2").getDocuments{ (QuerySnapshot, Error) in
            let err = Error
            if err != nil
            {
                print("Error getting documents: \(err)")
            }
            else
            {
                for document in QuerySnapshot!.documents
                {
                    let title = document.get("Title")
                    let postAuthor = document.get("Post Author")
                    let author = document.get("Author")
                    let blurb = document.get("Blurb")
                    let rating = document.get("Rating")
                    let review = document.get("Review")
                    let time = document.get("Date")
                    
                    let post = Post(bookName: title as! String, postAuthor: postAuthor as! String, bookAuthor: author as! String, blurb: blurb as! String, rating: rating as! Int, reviewString: review as! String, timeStamp: time as! FieldValue)
                    
                    tempPosts.insert(post, at: 0)
                }
                self.allPosts = tempPosts
                self.table.reloadData()
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as! PostTableViewCell
        cell.configure(with: allPosts[indexPath.row])
        return cell
    }
}
