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
    @IBOutlet var homeTableView: UITableView!
    var allPosts = [Post]()
    
    var tableView:UITableView!
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewDidLoad()
        homeTableView.dataSource = self
        homeTableView.delegate = self
        
        setUpElements()

        view.addSubview(homeTableView)
        homeTableView.translatesAutoresizingMaskIntoConstraints = false
        
        homeTableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        homeTableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        homeTableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        homeTableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
        
        

        
        homeTableView.register(UITableViewCell.self, forCellReuseIdentifier: "nameCell")
        
        //Setting up elements on the view
    }
         
     
    func setUpElements()
    {
        var tempPosts = [Post]()
        let db = Firestore.firestore()
        db.collection("Test").getDocuments{ (QuerySnapshot, Error) in
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
                    let author = document.get("Author")
                    let blurb = document.get("Blurb")
                    let rating = document.get("Rating")
                    let review = document.get("Review")
                    
                    let post = Post(bookName: title as! String, bookAuthor: author as! String, blurb: blurb as! String, rating: rating as! Int, reviewString: review as! String)
                    tempPosts.insert(post, at: 0)
                }
                self.allPosts = tempPosts
                self.homeTableView.reloadData()
                
//                for post in self.allPosts
//                {
//                    print(post.getWholePost())
//
//                }
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
          let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath)
          cell.textLabel?.text = allPosts[indexPath.row].bookName
          return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }
    
    
        
}
