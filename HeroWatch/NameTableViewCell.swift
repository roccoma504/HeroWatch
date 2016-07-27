//
//  NameTableViewCell.swift
//  
//
//  Created by Matthew Rocco on 6/30/16.
//
//

import UIKit

class NameTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var quickLevel: UILabel!
    @IBOutlet weak var competLevel: UILabel!
    @IBOutlet weak var competImage: UIImageView!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var consoleLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
