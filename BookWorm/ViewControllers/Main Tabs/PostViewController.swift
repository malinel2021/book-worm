//
//  PostViewController.swift
//  BookWorm
//
//  Created by Malin Leven on 16/12/2020.
//  Copyright © 2020 Malin Leven. All rights reserved.
//

import UIKit
import Firebase

class PostViewController: UIViewController
{
    var postAuthorUsername: String = ""
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var bookAuthorTextField: UITextField!
    
    @IBOutlet weak var blurbTextField: UITextView!
    
    @IBOutlet weak var ratingSlider: UISlider!

    @IBOutlet weak var reviewTextField: UITextView!
    
    @IBOutlet weak var postButton: UIButton!
    
    var currentPost = Post()
        
    override func viewDidLoad()
    {
        super.viewDidLoad()

        //Setting up elements on the view
        setUpElements()
    }
    
    func setUpElements()
    {
        Utilities.circularButton(button: postButton)
        Utilities.roundedText(textView: blurbTextField)
        Utilities.roundedText(textView: reviewTextField)
    }
    
    func createPost(post: Post)
    {
        let db = Firestore.firestore()
        db.collection("Posts").addDocument(data: [
            //Need to add current user id
            "Post Author": post.getPostAuthor(),
            "Title": post.getBookName(),
            "Author": post.getBookAuthor(),
            "Blurb": post.getBlurb(),
            "Rating": post.getRatingNumber(),
            "Review": post.getReviewString(),
            "Date": Utilities.getTimeString()
        ])
    }
    
    @IBAction func sliderChanged(_ sender: UISlider)
    {
        sender.value = roundf(sender.value);
    }

    @IBAction func postButtonTapped(_ sender: Any)
    {
        getTextFieldValues()
        createPost(post: currentPost)
        clearTextFields()
    }
    
    func clearTextFields()
    {
        titleTextField.text = ""
        bookAuthorTextField.text = ""
        blurbTextField.text = ""
        reviewTextField.text = ""
        ratingSlider.value = 3
    }
    
    func getTextFieldValues()
    {
        let title = titleTextField.text!
        let postAuthor = postAuthorUsername
        let author = bookAuthorTextField.text!
        let blurb = blurbTextField.text!
        let rating = Int(ratingSlider.value)
        let review = reviewTextField.text!
        let time = Utilities.getTimeString()
        currentPost = Post(bookName: title, postAuthor: postAuthor, bookAuthor: author, blurb: blurb, rating: rating, reviewString: review, timeString: time)
    }
}
