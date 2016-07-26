//
//  SummaryTableViewController.swift
//  HeroWatch
//
//  Created by Matthew Rocco on 7/22/16.
//  Copyright © 2016 Matthew Rocco. All rights reserved.
//

import ChameleonFramework
import UIKit

class SummaryTableViewController: UITableViewController {
    
    private let prefs = NSUserDefaults.standardUserDefaults()
    private var rankImage : UIImage!
    private var avatarImage : UIImage!
    private var rank : String!
    private var quickPlayLevel : String!
    private var avatarImageValid = false
    private var rankedImageValid = false
    private var drawn = false

    enum imageKind {
        case avatar
        case ranked
    }
    
    private func updateTable() {
        dispatch_async(dispatch_get_main_queue(),{
            self.tableView.reloadData()
        })
    }
    
    private func fetchImage(url : String, kind : imageKind) {
        JSONUtilities.downloadImage(NSURL(string: url)!) { (image, error) in
            if error != nil {
                UIUtilities.displayAlert(self, title: "Error!", message: (error?.localizedDescription)!)
            }
            else {
                switch kind {
                case .avatar:
                    self.avatarImage = image
                    self.avatarImageValid = true

                case .ranked:
                    self.rankImage = image
                    self.rankedImageValid = true
                }
                //self.updateTable()
            }
        }
        
    }
    
    private func getUserData () {
        
        // Retrieve the JSON for the user configuration.
        JSONUtilities.retrieve(URLUtilities.profileURL(prefs.stringForKey("console")!, region: prefs.stringForKey("region")!, userID: prefs.stringForKey("id")!)) { (json, error) in
            
            // Adjust the UI back to normal.
            UIUtilities.adjustAlpha(self.view, alpha: 1.0)
            
            // If we successfully retrieved
            if error != nil {
                UIUtilities.displayAlert(self, title: "Error!", message: (error?.localizedDescription)!)
            }
            else {
                self.fetchImage(json["data"]!["competitive"]!!["rank_img"] as! String, kind : .ranked)
                self.fetchImage(json["data"]!["avatar"] as! String, kind : .avatar)
                self.rank = json["data"]!["competitive"]!!["rank"] as! String
                self.quickPlayLevel = String(json["data"]!["level"] as! Int)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.whiteColor()
        UIUtilities.adjustAlpha(self.view, alpha: 0.5)
        getUserData()
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
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
        return 2
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell!
        
        if indexPath.row == 0 && avatarImageValid && rankedImageValid {
            
            let tempCell = tableView.dequeueReusableCellWithIdentifier("nameCell", forIndexPath: indexPath) as! NameTableViewCell
            tempCell.nameLabel.text = prefs.stringForKey("id")?.uppercaseString
            tempCell.regionLabel.text = prefs.stringForKey("region")?.uppercaseString
            tempCell.consoleLabel.text = prefs.stringForKey("console")?.uppercaseString
            tempCell.quickLevel.text = "QP: " + quickPlayLevel
            tempCell.competLevel.text = "RP: " + rank
            tempCell.competImage.image = rankImage
            tempCell.avatarImage.image = avatarImage
            tempCell.avatarImage.layer.cornerRadius = 16.0
            tempCell.avatarImage.clipsToBounds = true
            
            tempCell.backgroundColor = ContrastColorOf(PRIMARY_COLOR, returnFlat: true)
            cell = tempCell
        }
            
        else if indexPath.row == 1 && !drawn {
            
            let tempCell = tableView.dequeueReusableCellWithIdentifier("statCell", forIndexPath: indexPath) as! StatTableViewCell
            
            let circleAngles = CircleAngles(valueOne: "2", valueTwo: "2", valueThree: "2")
            
            print("E1 "+String(circleAngles.get(.EndOne)))
            print("E2 "+String(circleAngles.get(.EndTwo)))
            print("E3 "+String(circleAngles.get(.EndThree)))


            
            tempCell.circleOne.animateFromAngle(0, toAngle: circleAngles.get(.EndOne) , duration: 5.0, completion: nil)
            tempCell.circleOne.layer.zPosition = 2;
            tempCell.circleTwo.animateFromAngle(0, toAngle: circleAngles.get(.EndTwo) , duration: 5.0, completion: nil)
            tempCell.circleTwo.layer.zPosition = 1;
            tempCell.circleThree.animateFromAngle(0, toAngle: circleAngles.get(.EndThree) , duration: 5.0, completion: nil)
            tempCell.circleThree.layer.zPosition = 0;

            
            tempCell.oneLabel.text = "HI!"
            tempCell.backgroundColor = ContrastColorOf(PRIMARY_COLOR, returnFlat: true)
            cell = tempCell
            
            drawn = true

            
        
        }
        else {
            let tempCell = tableView.dequeueReusableCellWithIdentifier("nameCell", forIndexPath: indexPath) as! NameTableViewCell
            tempCell.backgroundColor = ContrastColorOf(PRIMARY_COLOR, returnFlat: true)
            tempCell.contentView.backgroundColor = ClearColor()
            
            tempCell.nameLabel.text = "LOADING..."
            cell = tempCell
        }
        
        return cell
    }
    
}
