//
//  FriendTableViewCell.swift
//  HeroWatch
//
//  Created by Matthew Rocco on 7/30/16.
//  Copyright © 2016 Matthew Rocco. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {

    @IBOutlet weak var quickImage: UIImageView!
    @IBOutlet weak var quickLabel: UILabel!
    @IBOutlet weak var rankedImage: UIImageView!
    @IBOutlet weak var rankedLevel: UILabel!
    @IBOutlet weak var battleTag: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
