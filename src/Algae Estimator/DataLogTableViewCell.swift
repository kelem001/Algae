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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("awake")
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        print("setSelected")
        // Configure the view for the selected state
    }
}
