//
//  ProfileTableViewCell.swift
//  BookWorm
//
//  Created by Malin Leven on 10/1/2021.
//  Copyright © 2021 Malin Leven. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell
{
    
    @IBOutlet var bookLabel: UILabel!
    
    @IBOutlet var ratingImageView: UIImageView!
    
    @IBOutlet var blurbLabel: UILabel!

    @IBOutlet var reviewLabel: UILabel!


    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
    
    static let identifier = "ProfileTableViewCell"

    static func nib () -> UINib
    {
        return UINib(nibName: "ProfileTableViewCell", bundle: nil)
    }
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.systemPink.cgColor
               
    }
    
    func configure(with model: Post)
    {
        self.bookLabel.text = model.bookName + " by " + model.bookAuthor
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
    }
}
