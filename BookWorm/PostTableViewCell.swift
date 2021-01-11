//
//  PostTableViewCell.swift
//  BookWorm
//
//  Created by Malin Leven on 9/1/2021.
//  Copyright © 2021 Malin Leven. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell
{
    //Book and author name
    @IBOutlet var bookLabel: UILabel!
    
    //Username
    @IBOutlet var usernameLabel: UILabel!
    
    //Blurb
    @IBOutlet var blurbLabel: UILabel!
    
    //Review
    @IBOutlet var reviewLabel: UILabel!
    
    //Rating stars image
    @IBOutlet var ratingImageView: UIImageView!
    
    //Timestamp
    @IBOutlet weak var timeStamp: UILabel!
    

    static let identifier = "PostTableViewCell"

    static func nib () -> UINib
    {
        return UINib(nibName: "PostTableViewCell", bundle: nil)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.purple.cgColor
               
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with model: Post)
    {
        self.bookLabel.text = model.bookName + " by " + model.bookAuthor
        self.usernameLabel.text = model.postAuthor
        let ratingNum = model.ratingNumber
        switch ratingNum
        {
        case 1:
            ratingImageView.image = UIImage(named: "1_star")
        case 2:
            ratingImageView.image = UIImage(named: "2_stars")
        case 3:
            ratingImageView.image = UIImage(named: "3_stars")
        case 4:
            ratingImageView.image = UIImage(named: "4_stars")
        case 5:
            ratingImageView.image = UIImage(named: "5_stars")
        default:
            print("No rating")
        }
        self.blurbLabel.text = model.blurb
        self.reviewLabel.text = model.reviewString
        self.timeStamp.text = model.timeString
    }
    
}
