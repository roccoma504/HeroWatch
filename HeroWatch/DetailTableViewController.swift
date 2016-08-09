//
//  DetailTableViewController.swift
//  HeroWatch
//
//  Created by Matthew Rocco on 8/8/16.
//  Copyright © 2016 Matthew Rocco. All rights reserved.
//

import ChameleonFramework
import UIKit

class DetailTableViewController: UITableViewController {
    
    private let prefs = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var modeButton: UIBarButtonItem!
    var receivedHero : String!
    var heroInfo : [String : AnyObject]!
    var isQuick = true
    
    
    @IBAction func modeButtonClick(sender: AnyObject) {
        changeMode()
        refreshControl?.beginRefreshing()
        getData()
    }
    
    private func changeMode() {
        if isQuick {
            modeButton.title = "Competitive"
            isQuick = false
        }
        else {
            modeButton.title = "Quick"
            isQuick = true
        }
        
    }
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        getData()
    }
    
    private func getData () {
        UIUtilities.adjustAlpha(view, alpha: 0.5)
        if isQuick {
            JSONUtilities.retrieve(URLUtilities.quickHeroesURL(prefs.stringForKey("console")!, region: prefs.stringForKey("region")!, userID: prefs.stringForKey("id")!, hero: receivedHero)) { (json, error) in
                // If we successfully retrieved
                if error != nil {
                    UIUtilities.displayAlert(self, title: "Error!", message: (error?.localizedDescription)!)
                    self.changeMode()
                }
                else {
                    self.heroInfo = json
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        self.tableView.reloadData()
                    })
                }
                self.refreshControl!.endRefreshing()
                UIUtilities.adjustAlpha(self.view, alpha: 1.0)
                
            }
        }
        else {
            JSONUtilities.retrieve(URLUtilities.compHeroesURL(prefs.stringForKey("console")!, region: prefs.stringForKey("region")!, userID: prefs.stringForKey("id")!, hero: receivedHero)) { (json, error) in
                
                // If we successfully retrieved
                if error != nil {
                    UIUtilities.displayAlert(self, title: "Error!", message: (error?.localizedDescription)!)
                    self.changeMode()
                }
                else {
                    self.heroInfo = json
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        self.tableView.reloadData()
                    })
                }
                self.refreshControl!.endRefreshing()
                
                UIUtilities.adjustAlpha(self.view, alpha: 1.0)
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl?.addTarget(self, action: "handleRefresh:", forControlEvents: UIControlEvents.ValueChanged)
        refreshControl?.beginRefreshing()
        view.backgroundColor = FlatOrange()
        title = receivedHero
        getData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        if let info = heroInfo where info[receivedHero]!.count != 0 {
            count = info[receivedHero]!.count
            if count == 0 {
                UIUtilities.displayAlert(self, title: "Error", message: "No data found. This is usually because there are no stats for this hero for this play mode.")
            }
        }
        
        return count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! DetailTableViewCell
        var dict = heroInfo[receivedHero] as! [String : AnyObject]
        
        let sortedKeys = Array(dict.keys).sort()
        
        cell.keyLabel.text = sortedKeys[indexPath.row].replaceUpper().replaceDash().removeExcessiveSpaces
        cell.valueLabel.text = dict[sortedKeys[indexPath.row]] as? String
        cell.backgroundColor = FlatWhite()
        
        
        
        return cell
    }
    
}
