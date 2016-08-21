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
    private let singleSection = ["All Heroes"]
    private let prefs = NSUserDefaults.standardUserDefaults()
    private let herosByClass = [OFFENSE_HEROES, DEFENSE_HEROES, TANK_HEROES, SUPPORT_HEROES]
    private var herosByName = [OFFENSE_HEROES + DEFENSE_HEROES + TANK_HEROES + SUPPORT_HEROES]
    private var heroesToDisplay = [OFFENSE_HEROES, DEFENSE_HEROES, TANK_HEROES, SUPPORT_HEROES]
    private var sectionToDisplay = ["Offense","Defense","Tank","Support"]

    private var receivedData : Array <String>!
    private var clickedHero : String!
    @IBOutlet weak var sortButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return self.sectionToDisplay[section]
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return self.sectionToDisplay.count
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return heroesToDisplay[section].count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! HeroTableViewCell
        
        let heroPic = UIImage(named: heroImageMap[heroesToDisplay[indexPath.section][indexPath.row]]!)
        
        cell.heroLabel.text = heroesToDisplay[indexPath.section][indexPath.row]
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
    
    @IBAction func sortButtonClick(sender: AnyObject) {
        
        if sortButton.title == "Sort By Class" {
            sortButton.title = "Sort By Name"
            herosByName[0].sortInPlace()
            print(herosByName[0])
            heroesToDisplay = herosByName
            sectionToDisplay = singleSection
        }
        else {
            sortButton.title = "Sort By Class"
            heroesToDisplay = herosByClass
            sectionToDisplay = section
        }
        
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
        })
        
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        clickedHero = heroesToDisplay[indexPath.section][indexPath.row]
        performSegueWithIdentifier("detailSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detailSegue" {
            let nvc = segue.destinationViewController as! UINavigationController
            let vc = nvc.childViewControllers[0] as! DetailTableViewController
            vc.receivedHero = clickedHero.replaceHeroes()
        }
    }
    
}
