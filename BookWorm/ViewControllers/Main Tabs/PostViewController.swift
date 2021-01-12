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
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var bookAuthorTextField: UITextField!
    
    @IBOutlet weak var blurbTextField: UITextView!
    
    @IBOutlet weak var ratingSlider: UISlider!

    @IBOutlet weak var reviewTextField: UITextView!
    
    @IBOutlet weak var postButton: UIButton!
    
    //Initialising the username of the author posting
    var postAuthorUsername: String = Constants.EMPTY

    //Creating a Post instance for the current user
    var currentPost = Post()
        
    override func viewDidLoad()
    {
        super.viewDidLoad()

        //Setting up elements on the view
        setUpElements()
    }
    
    func setUpElements()
    {
        //Changing aesthetics of the buttons and text views
        Utilities.circularButton(button: postButton)
        Utilities.roundedText(textView: blurbTextField)
        Utilities.roundedText(textView: reviewTextField)
    }
    
    //Rounding all slider values so that only the whole numbers 1, 2, 3, 4 and 5 can be selected
    @IBAction func sliderChanged(_ sender: UISlider)
    {
        sender.value = roundf(sender.value);
    }

    //Creating a new post when the post button is tapped
    @IBAction func postButtonTapped(_ sender: Any)
    {
        getTextFieldValues()
        createPost(post: currentPost)
        clearTextFields()
    }
    
    //Getting all the inputted information on the view
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
    
    //Creating a new post and sending data to Firestore
    func createPost(post: Post)
    {
        let db = Firestore.firestore()
        db.collection(Constants.POSTS).addDocument(data: [
            Constants.POST_AUTHOR: post.getPostAuthor(),
            Constants.TITLE: post.getBookName(),
            Constants.BOOK_AUTHOR: post.getBookAuthor(),
            Constants.BLURB: post.getBlurb(),
            Constants.RATING: post.getRatingNumber(),
            Constants.REVIEW: post.getReviewString(),
            Constants.DATE: Utilities.getTimeString()
        ])
    }
    
    //Resetting all the text fields on the view
    func clearTextFields()
    {
        titleTextField.text = Constants.EMPTY
        bookAuthorTextField.text = Constants.EMPTY
        blurbTextField.text = Constants.EMPTY
        reviewTextField.text = Constants.EMPTY
        ratingSlider.value = 3
    }
}
