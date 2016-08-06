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


    override func viewDidLoad() {
        super.viewDidLoad()
        title = prefs.stringForKey("id")!.uppercaseString

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
