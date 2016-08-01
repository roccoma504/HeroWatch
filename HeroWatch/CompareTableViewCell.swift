//
//  CompareTableViewCell.swift
//  HeroWatch
//
//  Created by Matthew Rocco on 8/1/16.
//  Copyright © 2016 Matthew Rocco. All rights reserved.
//

import UIKit

class CompareTableViewCell: UITableViewCell {

    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var statLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
