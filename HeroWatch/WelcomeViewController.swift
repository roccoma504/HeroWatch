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
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    private let prefs = NSUserDefaults.standardUserDefaults()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.hidesNavigationBarHairline = true
        welcomeLabel.textColor = PRIMARY_COLOR
        
        guard prefs.stringForKey("id") == nil else {
            performSegueWithIdentifier("setupSegue", sender: self)
            return
        }
    }
    
    /**
     Opens a link to the LootBox API
     */
    @IBAction func apiButtonClick(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://lootbox.eu")!)
        
    }
}
