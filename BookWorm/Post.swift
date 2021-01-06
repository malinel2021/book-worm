//
//  Post.swift
//  BookWorm
//
//  Created by Malin Leven on 6/1/2021.
//  Copyright © 2021 Malin Leven. All rights reserved.
//

import Foundation

class Post
{
    var bookName = ""
    var postAuthor = User()
    var bookAuthor = ""
    var blurb = ""
    var ratingNumber = 0
    var reviewString = ""
    
    init()
    {
        self.bookName = ""
        self.postAuthor = User()
        self.bookAuthor = ""
        self.blurb = ""
        self.ratingNumber = 0
        self.reviewString = ""
    }
    
    
    init(bookName: String, bookAuthor: String, blurb: String, reviewString: String)
    {
        self.bookName = bookName
        self.bookAuthor = bookAuthor
        self.blurb = blurb
        self.reviewString = reviewString
    }
    
    //Setters
    func setBookName(name: String)
    {
        self.bookName = name
    }
    
    func setPostAuthor(user: User)
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
    
    func getPostAuthor () -> User
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
    
    func getWholePost() -> String
    {
//        let ratingString = String(ratingNumber)
        
        
        return bookName + bookAuthor + blurb + reviewString
    }
}


