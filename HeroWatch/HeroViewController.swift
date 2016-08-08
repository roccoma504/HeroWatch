//
//  HeroViewController.swift
//  HeroWatch
//
//  Created by Matthew Rocco on 8/7/16.
//  Copyright © 2016 Matthew Rocco. All rights reserved.
//

import ChameleonFramework
import UIKit

class HeroViewController: UIViewController {
    
    private var receivedData : String!
    private let prefs = NSUserDefaults.standardUserDefaults()
    
    
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    @IBOutlet weak var oneLabel: UILabel!
    @IBOutlet weak var oneValue: UILabel!
    @IBOutlet weak var twoLabel: UILabel!
    @IBOutlet weak var twoValue: UILabel!
    @IBOutlet weak var threeLabel: UILabel!
    @IBOutlet weak var threeValue: UILabel!
    @IBOutlet weak var fourLabel: UILabel!
    @IBOutlet weak var fourValue: UILabel!
    @IBOutlet weak var fiveLabel: UILabel!
    @IBOutlet weak var fiveValue: UILabel!
    @IBOutlet weak var sixLabel: UILabel!
    @IBOutlet weak var sixValue: UILabel!
    @IBOutlet weak var sevenLabel: UILabel!
    @IBOutlet weak var sevenValue: UILabel!
    @IBOutlet weak var eightLabel: UILabel!
    @IBOutlet weak var eightValue: UILabel!
    @IBOutlet weak var nineLabel: UILabel!
    @IBOutlet weak var nineValue: UILabel!
    @IBOutlet weak var modeButton: UIBarButtonItem!
    
    private var isQuick = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "findHero:",name:"pickedHero", object: receivedData)
        UIUtilities.adjustAlpha(view, alpha: 0.5)
        
    }
    
    
    
    func findHero(notification: NSNotification) {
        
        
        let labelArray = [self.oneLabel, self.twoLabel, self.threeLabel, self.fourLabel, self.fiveLabel, self.sixLabel, self.sevenLabel, self.eightLabel, self.nineLabel]
        let valueArray = [self.oneValue, self.twoValue, self.threeValue, self.fourValue, self.fiveValue, self.sixValue, self.sevenValue, self.eightValue, self.nineValue]
        
        
        self.receivedData = notification.object as! String
        UIUtilities.adjustActivity(self.activityView, stop: false)
        UIUtilities.adjustAlpha(view, alpha: 0.5)
        
        for i in 0..<labelArray.count {
            UIUtilities.hideView(labelArray[i], hide: true)
            UIUtilities.hideView(valueArray[i], hide: true)
        }
        
        if isQuick {
            // Retrieve the JSON for the user configuration.
            JSONUtilities.retrieve(URLUtilities.quickHeroesURL(prefs.stringForKey("console")!, region: prefs.stringForKey("region")!, userID: prefs.stringForKey("id")!,hero: receivedData)) { (json, error) in
                // If we successfully retrieved
                if error != nil {
                    UIUtilities.displayAlert(self, title: "Error!", message: (error?.localizedDescription)!)
                }
                else {
                    self.updateView(json[self.receivedData] as! [String : AnyObject])
                }
            }
        }
        else {
            // Retrieve the JSON for the user configuration.
            JSONUtilities.retrieve(URLUtilities.compHeroesURL(prefs.stringForKey("console")!, region: prefs.stringForKey("region")!, userID: prefs.stringForKey("id")!,hero: receivedData)) { (json, error) in
                // If we successfully retrieved
                if error != nil {
                    UIUtilities.displayAlert(self, title: "Error!", message: (error?.localizedDescription)!)
                }
                else {
                    self.updateView(json[self.receivedData] as! [String : AnyObject])
                }
            }
        }
        
        
    }
    
    private func updateView(heroStats : [String : AnyObject]) {
        dispatch_async(dispatch_get_main_queue(), {
            
            let labelArray = [self.oneLabel, self.twoLabel, self.threeLabel, self.fourLabel, self.fiveLabel, self.sixLabel, self.sevenLabel, self.eightLabel, self.nineLabel]
            let valueArray = [self.oneValue, self.twoValue, self.threeValue, self.fourValue, self.fiveValue, self.sixValue, self.sevenValue, self.eightValue, self.nineValue]
            
            
            UIUtilities.adjustActivity(self.activityView, stop: true)
            UIUtilities.adjustAlpha(self.view, alpha: 1.0)
            
            print(heroStats)
            
            let keyArray = ["Deaths-Average","Eliminations-Average","SoloKills","WeaponAccuracy","EliminationsperLife","GamesPlayed","Medals-Gold","Medals-Silver","Medals-Bronze"]
            let noteArray = ["Avg. Deaths","Avg. Kills.", "Solo Kills","Accuracy","Kills Per Life","Played","Gold","Silver","Bronze"]
            
            var error = false
            
            for i in 0..<keyArray.count {
                if let value = heroStats[keyArray[i]] as? String {
                    labelArray[i].text = noteArray[i]
                    labelArray[i].textColor = FlatOrangeDark()
                    valueArray[i].text = value
                    valueArray[i].textColor = FlatOrange()
                    UIUtilities.hideView(labelArray[i], hide: false)
                    UIUtilities.hideView(valueArray[i], hide: false)
                    
                }
                else {
                    error = true
                }
            }
            if error {
                UIUtilities.displayAlert(self, title: "Error", message: "Some data missing for this hero. Some or all fields missing. Try playing more!")
            }
        })
    }
    
    @IBAction func modeButtonClick(sender: AnyObject) {
        if isQuick {
            isQuick = false
            modeButton.title = "Competitive Play"
        }
        else {
            isQuick = true
            modeButton.title = "Quick Play"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
