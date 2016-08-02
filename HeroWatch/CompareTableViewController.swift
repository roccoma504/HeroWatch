//
//  CompareTableViewController.swift
//  HeroWatch
//
//  Created by Matthew Rocco on 8/1/16.
//  Copyright © 2016 Matthew Rocco. All rights reserved.
//

import UIKit

class CompareTableViewController: UITableViewController {

    private let prefs = NSUserDefaults.standardUserDefaults()
    
    var receviedPlayer : Friend!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CompareTableViewCell
        
        if indexPath.row == 0 {
            cell.statLabel.hidden = true
            cell.leftLabel.text = prefs.stringForKey("id")
            cell.rightLabel.text = receviedPlayer.get(.Name)

        
        }
        
        return cell
    }
    
}
