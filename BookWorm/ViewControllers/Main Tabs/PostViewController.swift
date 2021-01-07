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
    
    
    var currentPost = Post()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
        db.collection("Test").addDocument(data: [
            //Need to add current user id
            "Title": post.getBookName(),
            "Author": post.getBookAuthor(),
            "Blurb": post.getBlurb(),
            "Rating": post.getRatingNumber(),
            "Review": post.getReviewString()
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
    }
    
    func getTextFieldValues()
    {
        let title = titleTextField.text!
        let author = bookAuthorTextField.text!
        let blurb = blurbTextField.text!
        let rating = Int(ratingSlider.value)
        let review = reviewTextField.text!

        
        currentPost = Post(bookName: title, bookAuthor: author, blurb: blurb, rating: rating, reviewString: review)
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
