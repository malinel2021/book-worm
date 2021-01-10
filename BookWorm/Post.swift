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
    var timeStamp: FieldValue?
//    var bookImageName = ""
//    var ratingImageName = ""
    
    init()
    {
        self.bookName = ""
        self.postAuthor = ""
        self.bookAuthor = ""
        self.blurb = ""
        self.ratingNumber = 0
        self.reviewString = ""
        self.timeStamp = nil
//        self.bookImageName = ""
//        self.ratingImageName = ""
    }
    
    
    init(bookName: String, postAuthor: String, bookAuthor: String, blurb: String, rating: Int, reviewString: String, timeStamp: FieldValue?)
    {
        self.bookName = bookName
        self.postAuthor = postAuthor
        self.bookAuthor = bookAuthor
        self.blurb = blurb
        self.ratingNumber = rating
        self.reviewString = reviewString
        self.timeStamp = timeStamp
    }
    
    //Setters
    func setBookName(name: String)
    {
        self.bookName = name
    }
    
    
    func setPostAuthor(user: String)
    {
        self.postAuthor = user
    }
    
    func setBookAuthor(name: String)
    {
        self.bookAuthor = name
    }
    
    func setBlub(blurb: String)
    {
        self.blurb = blurb
    }
    
    func setRatingNumber(num: Int)
    {
        self.ratingNumber = num
    }
    
    func setReviewString(review: String)
    {
        self.reviewString = review
    }
    
    //Getters
    func getBookName () -> String
    {
        return bookName
    }
    
    func getPostAuthor () -> String
    {
        return postAuthor
    }
    
    
    func getBookAuthor () -> String
    {
        return bookAuthor
    }
    
    func getBlurb () -> String
    {
        return blurb
    }
    
    func getRatingNumber () -> Int
    {
        return ratingNumber
    }
    
    func getReviewString () -> String
    {
        return reviewString
    }
}


