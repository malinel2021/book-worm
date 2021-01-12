//
//  Post.swift
//  BookWorm
//
//  Created by Malin Leven on 6/1/2021.
//  Copyright © 2021 Malin Leven. All rights reserved.
//

import Foundation
import Firebase

class Post
{
    var bookName: String!
    var postAuthor: String!
    var bookAuthor: String!
    var blurb: String!
    var ratingNumber: Int!
    var reviewString: String!
    var timeString: String!
    
    init()
    {
        self.bookName = Constants.EMPTY
        self.postAuthor = Constants.EMPTY
        self.bookAuthor = Constants.EMPTY
        self.blurb = Constants.EMPTY
        self.ratingNumber = Constants.ZERO
        self.reviewString = Constants.EMPTY
        self.timeString = Constants.EMPTY
    }
    
    init(bookName: String, postAuthor: String, bookAuthor: String, blurb: String, rating: Int, reviewString: String, timeString: String)
    {
        self.bookName = bookName
        self.postAuthor = postAuthor
        self.bookAuthor = bookAuthor
        self.blurb = blurb
        self.ratingNumber = rating
        self.reviewString = reviewString
        self.timeString = timeString
    }
    
    //Getting the book name and author in one String
    func getBookNameAndAuthor () -> String
    {
        return bookName + Constants.BY + bookAuthor
    }
}


