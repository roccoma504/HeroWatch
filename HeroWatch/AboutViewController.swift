//
//  AboutViewController.swift
//  HeroWatch
//
//  Created by Matthew Rocco on 8/6/16.
//  Copyright © 2016 Matthew Rocco. All rights reserved.
//

import ChameleonFramework
import UIKit

class AboutViewController: UIViewController {
    
    @IBOutlet weak var kyButton: UIButton!
    @IBOutlet weak var chameleonButton: UIButton!
    @IBOutlet weak var lootBoxButton: UIButton!
    @IBOutlet weak var tweetButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lootBoxButton.backgroundColor = FlatOrange()
        tweetButton.backgroundColor = FlatBlue()
        kyButton.backgroundColor = FlatMint()
        chameleonButton.backgroundColor = FlatMagenta()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func lookboxClick(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://lootbox.eu")!)
    }
    
    @IBAction func kyClick(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://github.com/kentya6/KYCircularProgress")!)
        
    }
    @IBAction func chameleonClick(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://github.com/ViccAlexander/Chameleon")!)
        
    }
    
    @IBAction func tweetClick(sender: AnyObject) {
        let screenName =  "Bytechomp"
        let appURL = NSURL(string: "twitter://user?screen_name=\(screenName)")!
        let webURL = NSURL(string: "https://twitter.com/\(screenName)")!
        
        let application = UIApplication.sharedApplication()
        
        if application.canOpenURL(appURL) {
            application.openURL(appURL)
        } else {
            application.openURL(webURL)
        }
    }
    
}
