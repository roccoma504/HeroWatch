//
//  StatTableViewCell.swift
//  hw
//
//  Created by Matthew Rocco on 6/30/16.
//  Copyright © 2016 Matthew Rocco. All rights reserved.
//

import UIKit
import CorePlot


class StatTableViewCell: UITableViewCell {

    @IBOutlet weak var oneLabel: UILabel!
    @IBOutlet weak var twoLabel: UILabel!
    @IBOutlet weak var threeLabel: UILabel!
    @IBOutlet weak var fourLabel: UILabel!
    @IBOutlet weak var fiveLabel: UILabel!
    @IBOutlet weak var sixLabel: UILabel!
    @IBOutlet weak var sevenLabel: UILabel!
    @IBOutlet weak var circleOne: KDCircularProgress!
    @IBOutlet weak var circleTwo: KDCircularProgress!
    @IBOutlet weak var circleThree: KDCircularProgress!
    @IBOutlet weak var circleFour: KDCircularProgress!
    @IBOutlet weak var circleFive: KDCircularProgress!
    @IBOutlet weak var circleSix: KDCircularProgress!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
