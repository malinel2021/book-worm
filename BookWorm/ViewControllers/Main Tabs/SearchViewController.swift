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

//Tutorial used to help configure search bar: https://vasundharavision.com/blog/ios/how-to-use-search-bar-in-table-view#664
class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate
{
    @IBOutlet var table: UITableView!
    
    @IBOutlet var searchBar: UISearchBar!
    
    //Array to hold all the posts from Firestore
    var rawData = [Post]()
    
    //Array to hold all posts from Firestore to be displayed when searching
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
        
        //Setting up elements on the view
        setUpElements()
        
        //Initialising array with search data
        searchData = rawData
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
                //For loop to get data for each post and create a Post instance with the data
                for document in QuerySnapshot!.documents
                {
                    let title = document.get(Constants.TITLE)
                    let postAuthor = document.get(Constants.POST_AUTHOR)
                    let author = document.get(Constants.BOOK_AUTHOR)
                    let blurb = document.get(Constants.BLURB)
                    let rating = document.get(Constants.RATING)
                    let review = document.get(Constants.REVIEW)
                    let time = document.get(Constants.DATE)
                    let post = Post(bookName: title as! String, postAuthor: postAuthor as! String, bookAuthor: author as! String, blurb: blurb as! String, rating: rating as! Int, reviewString: review as! String, timeString: time as! String)
                        
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
    
    //What to do when the search bar is cancelled
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
        searchBar.text = Constants.EMPTY
        searchData = rawData
        searchBar.endEditing(true)
        table.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        searchData = searchText.isEmpty ? rawData : rawData.filter
        {
            (item: Post) -> Bool in
            //If the book name or author matches the searched data, return the range
            let str = item.getBookNameAndAuthor()
            return str.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        table.reloadData()
    }
}
