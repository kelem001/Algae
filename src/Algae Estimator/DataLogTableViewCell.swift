//
//  DataLogTableViewCell.swift
//  Algae Estimator
//
//  Created by Andrew Barrett on 11/5/16.
//  Copyright © 2016 Software Engineering. All rights reserved.
//
import UIKit
import CoreData

class DataLogTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    //@IBOutlet weak var shareButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}