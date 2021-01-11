//
//  SearchViewController.swift
//  BookWorm
//
//  Created by Malin Leven on 5/1/2021.
//  Copyright © 2021 Malin Leven. All rights reserved.
//

import Foundation
import UIKit
import Firebase

//https://vasundharavision.com/blog/ios/how-to-use-search-bar-in-table-view#664
class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate
{
    @IBOutlet var table: UITableView!
    
    @IBOutlet var searchBar: UISearchBar!
    
    var rawData = [Post]()
    
    var searchData = [Post]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //Setting up the table with the type of table cell it will be using
        table.register(PostTableViewCell.nib(), forCellReuseIdentifier: PostTableViewCell.identifier)
        table.delegate = self
        table.dataSource = self
        
        //Set up search bar
        searchBar.delegate = self
        
        setUpElements()
        
        searchData = rawData
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
                //For loop to get data for each post and create a Post instance with the data
                for document in QuerySnapshot!.documents
                {
                    let postAuthor = document.get("Post Author") as! String
                    let title = document.get("Title")
                    let author = document.get("Author")
                    let blurb = document.get("Blurb")
                    let rating = document.get("Rating")
                    let review = document.get("Review")
                    let time = document.get("Date")
                    let post = Post(bookName: title as! String, postAuthor: postAuthor, bookAuthor: author as! String, blurb: blurb as! String, rating: rating as! Int, reviewString: review as! String, timeString: time as! String)
                        
                    //Adding each post to the temporary Array, sorting by time with the newest post at the top
                    tempPosts.append(post)
                    tempPosts = tempPosts.sorted { $0.timeString > $1.timeString }
                }
                //Setting the array for the table and reloading
                self.rawData = tempPosts
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
        return searchData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as! PostTableViewCell
        cell.configure(with: searchData[indexPath.row])
        return cell
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
        searchBar.text = ""
        searchData = rawData
        searchBar.endEditing(true)
        table.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        searchData = searchText.isEmpty ? rawData : rawData.filter
        {
            (item: Post) -> Bool in
        // If dataItem matches the searchText, return true to include it
            let str = item.getBookNameAndAuthor()
            return str.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        table.reloadData()
    }
}
