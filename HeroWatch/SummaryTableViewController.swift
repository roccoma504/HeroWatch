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
    
    private var avatarImageValid = false
    private var rankedImageValid = false
    private var quickDataValid = false
    private var competitiveDataValid = false

    private var userInfo : User!
    private var quickHerosInfo : Heroes!
    private var competitiveHerosInfo : Heroes!


    private enum imageKind {
        case avatar
        case ranked
    }
    
    private func updateTable() {
        dispatch_async(dispatch_get_main_queue(),{
            self.tableView.reloadData()
        })
    }
    
    private func allDataValid() -> Bool {
        return avatarImageValid && rankedImageValid && quickDataValid && competitiveDataValid
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
                self.updateTable()
            }
        }
    }
    
    private func getHeroData() {
        
        // Retrieve the JSON for the user configuration.
        JSONUtilities.retrieve(URLUtilities.quickPlayURL(prefs.stringForKey("console")!, region: prefs.stringForKey("region")!, userID: prefs.stringForKey("id")!)) { (json, error) in
            // If we successfully retrieved
            if error != nil {
                UIUtilities.displayAlert(self, title: "Error!", message: (error?.localizedDescription)!)
            }
            else {
                self.quickHerosInfo = Heroes(JSON: json)
                self.quickDataValid = true

            }
        }

        // Retrieve the JSON for the user configuration.
        JSONUtilities.retrieve(URLUtilities.compPlayURL(prefs.stringForKey("console")!, region: prefs.stringForKey("region")!, userID: prefs.stringForKey("id")!)) { (json, error) in
            // If we successfully retrieved
            if error != nil {
                UIUtilities.displayAlert(self, title: "Error!", message: (error?.localizedDescription)!)
            }
            else {
                self.quickHerosInfo = Heroes(JSON: json)
                self.competitiveDataValid = true
            }
        }
    }
    
    private func getUserData() {
        // Retrieve the JSON for the user configuration.
        JSONUtilities.retrieve(URLUtilities.profileURL(prefs.stringForKey("console")!, region: prefs.stringForKey("region")!, userID: prefs.stringForKey("id")!)) { (json, error) in
            // If we successfully retrieved
            if error != nil {
                UIUtilities.displayAlert(self, title: "Error!", message: (error?.localizedDescription)!)
            }
            else {
                self.userInfo = User(JSON: json)
                self.fetchImage(self.userInfo.get(.RankImg) as! String, kind : .ranked)
                self.fetchImage(self.userInfo.get(.Avatar) as! String, kind : .avatar)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.whiteColor()
        UIUtilities.adjustAlpha(self.view, alpha: 0.5)
        getUserData()
        getHeroData()
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row != 0
        {
            return 110
        }
        else {
            return 100
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if allDataValid() {
            return 2
        }
        else {
            return 1
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell!
        
        let colors = ColorSchemeOf(.Complementary, color: PRIMARY_COLOR, isFlatScheme: true)
        
        if indexPath.row == 0 && allDataValid() {
            
            UIUtilities.adjustAlpha(self.view, alpha: 1.0)
            
            let tempCell = tableView.dequeueReusableCellWithIdentifier("nameCell", forIndexPath: indexPath) as! NameTableViewCell
            tempCell.nameLabel.text = prefs.stringForKey("id")?.uppercaseString
            tempCell.regionLabel.text = prefs.stringForKey("region")?.uppercaseString
            tempCell.consoleLabel.text = prefs.stringForKey("console")?.uppercaseString
            tempCell.quickLevel.text = "QP: " + (self.userInfo.get(.Rank) as! String)
            tempCell.competLevel.text = "RP: " + String((self.userInfo.get(.Level) as! Int))
            tempCell.competImage.image = rankImage
            tempCell.avatarImage.image = avatarImage
            tempCell.avatarImage.layer.cornerRadius = 16.0
            tempCell.avatarImage.clipsToBounds = true
            
            cell = tempCell
        }
            
        else if indexPath.row == 1 && allDataValid(){
            

            
            let tempCell = tableView.dequeueReusableCellWithIdentifier("statCell", forIndexPath: indexPath) as! StatTableViewCell
            
            let quickAngles = CircleAngles(valueOne: self.userInfo.get(.QW) as! String, valueTwo: self.userInfo.get(.QL) as! String)
            let competitiveAngles = CircleAngles(valueOne: self.userInfo.get(.CW) as! String, valueTwo: self.userInfo.get(.CL) as! String)
            
            tempCell.circleOne.animateFromAngle(0, toAngle: quickAngles.get(.EndOne) , duration: 5.0, completion: nil)
            tempCell.circleOne.layer.zPosition = 2
            tempCell.circleOne.setColors(colors[0])
            tempCell.circleTwo.animateFromAngle(0, toAngle: quickAngles.get(.EndTwo) , duration: 10.0, completion: nil)
            tempCell.circleTwo.layer.zPosition = 1
            tempCell.circleTwo.setColors(colors[1])
            tempCell.oneLabel.text = "Win:" + (self.userInfo.get(.QW) as! String)
            tempCell.oneLabel.textColor = colors[0]
            tempCell.twoLabel.text = "Lost:" + (self.userInfo.get(.QL) as! String)
            tempCell.twoLabel.textColor = colors[1]
            tempCell.circleFour.animateFromAngle(0, toAngle: competitiveAngles.get(.EndOne) , duration: 5.0, completion: nil)
            tempCell.circleFour.layer.zPosition = 2
            tempCell.circleFour.setColors(colors[0])
            tempCell.circleFive.animateFromAngle(0, toAngle: competitiveAngles.get(.EndTwo) , duration: 10.0, completion: nil)
            tempCell.circleFive.layer.zPosition = 1
            tempCell.circleFive.setColors(colors[1])
            tempCell.threeLabel.text = "Win:" + (self.userInfo.get(.CW) as! String)
            tempCell.threeLabel.textColor = colors[0]
            tempCell.fourLabel.text = "Lost:" + (self.userInfo.get(.CL) as! String)
            tempCell.fourLabel.textColor = colors[1]
            
            
            tempCell.sixLabel.hidden = true
            tempCell.sevenLabel.hidden = true
            tempCell.fiveLabel.hidden = true
            cell = tempCell
        }
            
        else if indexPath.row == 2 && allDataValid(){
            
            let tempCell = tableView.dequeueReusableCellWithIdentifier("statCell", forIndexPath: indexPath) as! StatTableViewCell
            let quickAngles = CircleAngles(valueOne: self.quickHerosInfo.get(.QW) as! String, valueTwo: self.quickHerosInfo.get(.QL) as! String)
            let competitiveAngles = CircleAngles(valueOne: self.competitiveHerosInfo.get(.CW) as! String, valueTwo: self.competitiveHerosInfo.get(.CL) as! String)
            
            tempCell.circleOne.animateFromAngle(0, toAngle: quickAngles.get(.EndOne) , duration: 5.0, completion: nil)
            tempCell.circleOne.layer.zPosition = 2
            tempCell.circleOne.setColors(colors[0])
            tempCell.circleTwo.animateFromAngle(0, toAngle: quickAngles.get(.EndTwo) , duration: 10.0, completion: nil)
            tempCell.circleTwo.layer.zPosition = 1
            tempCell.circleTwo.setColors(colors[1])
            tempCell.oneLabel.text = "Win:" + (self.userInfo.get(.QW) as! String)
            tempCell.oneLabel.textColor = colors[0]
            tempCell.twoLabel.text = "Lost:" + (self.userInfo.get(.QL) as! String)
            tempCell.twoLabel.textColor = colors[1]
            tempCell.circleFour.animateFromAngle(0, toAngle: competitiveAngles.get(.EndOne) , duration: 5.0, completion: nil)
            tempCell.circleFour.layer.zPosition = 2
            tempCell.circleFour.setColors(colors[0])
            tempCell.circleFive.animateFromAngle(0, toAngle: competitiveAngles.get(.EndTwo) , duration: 10.0, completion: nil)
            tempCell.circleFive.layer.zPosition = 1
            tempCell.circleFive.setColors(colors[1])
            tempCell.threeLabel.text = "Win:" + (self.userInfo.get(.CW) as! String)
            tempCell.threeLabel.textColor = colors[0]
            tempCell.fourLabel.text = "Lost:" + (self.userInfo.get(.CL) as! String)
            tempCell.fourLabel.textColor = colors[1]
            
            
            tempCell.sixLabel.hidden = true
            tempCell.sevenLabel.hidden = true
            tempCell.fiveLabel.hidden = true
            cell = tempCell
            
        }

            
        else {
            let tempCell = tableView.dequeueReusableCellWithIdentifier("nameCell", forIndexPath: indexPath) as! NameTableViewCell
            tempCell.contentView.backgroundColor = ClearColor()
            tempCell.nameLabel.text = "LOADING"
            cell = tempCell
        }
        
        return cell
    }
    
}
