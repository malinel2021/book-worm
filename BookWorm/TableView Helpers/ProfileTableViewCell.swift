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
    
    @IBOutlet var timeStamp: UILabel!
    
    static let identifier = Constants.PROFILE_TABLE_VC

    static func nib () -> UINib
    {
        return UINib(nibName: Constants.PROFILE_TABLE_VC, bundle: nil)
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        //Formatting table
        Utilities.formatTable(tableView: self)
        self.layer.borderColor = UIColor.blue.cgColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with model: Post)
    {
        //Setting all the information in the cells
        self.bookLabel.text = model.bookName + Constants.BY + model.bookAuthor
        let ratingNum = model.ratingNumber
        switch ratingNum
        {
        case 1:
            ratingImageView.image = UIImage(named: Constants.ONE_STAR)
        case 2:
            ratingImageView.image = UIImage(named: Constants.TWO_STARS)
        case 3:
            ratingImageView.image = UIImage(named: Constants.THREE_STARS)
        case 4:
            ratingImageView.image = UIImage(named: Constants.FOUR_STARS)
        case 5:
            ratingImageView.image = UIImage(named: Constants.FIVE_STARS)
        default:
            print(Constants.NO_RATING)
        }
        self.blurbLabel.text = model.blurb
        self.reviewLabel.text = model.reviewString
        self.timeStamp.text = model.timeString
    }
}
