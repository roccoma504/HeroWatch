//
//  HeroTableViewController.swift
//  HeroWatch
//
//  Created by Matthew Rocco on 8/6/16.
//  Copyright © 2016 Matthew Rocco. All rights reserved.
//

import ChameleonFramework
import UIKit

class HeroTableViewController: UITableViewController {
    
    private let section = ["Offense","Defense","Tank","Support"]
    private let prefs = NSUserDefaults.standardUserDefaults()
    private let items = [OFFENSE_HEROES, DEFENSE_HEROES, TANK_HEROES,SUPPORT_HEROES]
    private var receivedData : Array <String>!
    private var clickedHero : String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return self.section[section]
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return self.section.count
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items[section].count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! HeroTableViewCell
        
        let heroPic = UIImage(named: heroImageMap[items[indexPath.section][indexPath.row]]!)
        
        cell.heroLabel.text = items[indexPath.section][indexPath.row]
        cell.heroLabel.textColor = FlatBlack()
        cell.backgroundColor = FlatWhite()
        
        dispatch_async(dispatch_get_main_queue(), {
            cell.heroImage.image = heroPic
            cell.heroImage.layer.borderWidth = 1.0
            cell.heroImage.layer.masksToBounds = false
            cell.heroImage.layer.borderColor = FlatBlack().CGColor
            cell.heroImage.layer.cornerRadius = cell.heroImage.frame.size.width/2
            cell.heroImage.clipsToBounds = true
        })
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        clickedHero = items[indexPath.section][indexPath.row]
        performSegueWithIdentifier("detailSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let nvc = segue.destinationViewController as! UINavigationController
        let vc = nvc.childViewControllers[0] as! DetailTableViewController
        vc.receivedHero = clickedHero
    }
    
}
