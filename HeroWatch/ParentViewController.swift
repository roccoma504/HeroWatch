//
//  ParentViewController.swift
//  HeroWatch
//
//  Created by Matthew Rocco on 8/5/16.
//  Copyright © 2016 Matthew Rocco. All rights reserved.
//

import UIKit

class ParentViewController: UIViewController {
    
    private let prefs = NSUserDefaults.standardUserDefaults()
    
    
    @IBOutlet weak var quickPlayButton: UIBarButtonItem!
    
    @IBAction func switchPlayButton(sender: AnyObject) {
        var isQuick : Bool!
        
        if prefs.boolForKey("quickMode") {
            prefs.setBool(false, forKey: "quickMode")
            isQuick = false
            quickPlayButton.title = "Competitive Play"
        }
        else {
            prefs.setBool(true, forKey: "quickMode")
            isQuick = true
        }
        NSNotificationCenter.defaultCenter().postNotificationName("switch", object: isQuick)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = prefs.stringForKey("id")!.uppercaseString
        prefs.setBool(true, forKey: "quickMode")
        quickPlayButton.title = "Quick Play"
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
