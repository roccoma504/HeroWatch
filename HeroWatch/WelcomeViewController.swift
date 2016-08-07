//
//  WelcomeViewController.swift
//  HeroWatch
//
//  Created by Matthew Rocco on 7/19/16.
//  Copyright © 2016 Matthew Rocco. All rights reserved.
//

import ChameleonFramework
import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var blizzardLabel: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.hidesNavigationBarHairline = true
        welcomeLabel.textColor = PRIMARY_COLOR
    }
    
    /**
     Opens a link to the LootBox API
     */
    @IBAction func apiButtonClick(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://lootbox.eu")!)

    }
}
