//
//  UserViewController.swift
//  HeroWatch
//
//  Created by Matthew Rocco on 7/19/16.
//  Copyright © 2016 Matthew Rocco. All rights reserved.
//

import ChameleonFramework
import UIKit

class UserViewController: UIViewController {

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
            else {
                self.prefs.setObject(id, forKey: "id")
                self.prefs.setObject(console, forKey: "console")
                self.prefs.setObject(region, forKey: "region")
                self.prefs.setObject(json["data"]!["avatar"] as! String, forKey: "https://blzgdapipro-a.akamaihd.net/game/unlocks/0x02500000000008C5.png")
                self.performSegueWithIdentifier("setUpComplete", sender: self)

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
