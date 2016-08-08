//
//  HeroTableViewCell.swift
//  HeroWatch
//
//  Created by Matthew Rocco on 8/6/16.
//  Copyright © 2016 Matthew Rocco. All rights reserved.
//

import UIKit

class HeroTableViewCell: UITableViewCell {

    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var heroLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
