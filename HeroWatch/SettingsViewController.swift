//
//  SettingsViewController.swift
//  HeroWatch
//
//  Created by Matthew Rocco on 7/29/16.
//  Copyright © 2016 Matthew Rocco. All rights reserved.
//

import ChameleonFramework
import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var platformSelector: UISegmentedControl!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var regionSelector: UISegmentedControl!
    
    private let prefs = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.hidesNavigationBarHairline = true
        view.backgroundColor = ContrastColorOf(PRIMARY_COLOR, returnFlat: true)
        
        instructionLabel.textColor = SECONDARY_COLOR
        checkButton.backgroundColor = PRIMARY_COLOR
        checkButton.layer.cornerRadius = 5
        checkButton.layer.borderWidth = 1
        checkButton.setTitleColor(ContrastColorOf(PRIMARY_COLOR, returnFlat: true), forState: .Normal)
        checkButton.layer.borderColor = PRIMARY_COLOR.CGColor
        idTextField.text = prefs.stringForKey("id")
        platformSelector.selectedSegmentIndex = CONSOLE_ARRAY.indexOf(self.prefs.stringForKey("console")!)!
        regionSelector.selectedSegmentIndex = REGION_ARRAY.indexOf(self.prefs.stringForKey("region")!)!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func checkButtonClick(sender: AnyObject) {
        
        // Disable to UI.
        UIUtilities.adjustAlpha(self.view, alpha: 0.5)
        UIUtilities.adjustActivity(loadingView, stop: false)
        checkButton.enabled = false
        
        let console = CONSOLE_ARRAY[platformSelector.selectedSegmentIndex]
        let region = REGION_ARRAY[regionSelector.selectedSegmentIndex]
        let id = idTextField.text!
        
        // Retrieve the JSON for the user configuration.
        JSONUtilities.retrieve(URLUtilities.profileURL(console, region: region, userID: id)) { (json, error) in
            
            // Adjust the UI back to normal.
            UIUtilities.adjustAlpha(self.view, alpha: 1.0)
            UIUtilities.adjustActivity(self.loadingView, stop: true)
            self.checkButton.enabled = true
            
            if error != nil {
                UIUtilities.displayAlert(self, title: "Error!", message: (error?.localizedDescription)!)
            }
            else if json["error"] != nil {
                UIUtilities.displayAlert(self, title: "Error!", message: json["error"] as! String)
                
            }
            else {
                UIUtilities.displayAlert(self, title: "Success!", message: "Information updated.")
                
                NSOperationQueue.mainQueue().addOperationWithBlock {
                    self.prefs.setObject(id, forKey: "id")
                    self.prefs.setObject(console, forKey: "console")
                    self.prefs.setObject(region, forKey: "region")
                    self.prefs.setObject(json["level"], forKey: "level")
                    self.prefs.setObject(json["data"]!["competitive"]!!["rank"] as! String, forKey: "rank")
                    self.prefs.setObject(json["data"]!["avatar"] as! String, forKey: "avatar")
                    self.performSegueWithIdentifier("setUpComplete", sender: self)
                }
                
            }
            print (json)
        }
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
