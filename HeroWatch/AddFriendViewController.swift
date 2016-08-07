//
//  AddFriendViewController.swift
//  HeroWatch
//
//  Created by Matthew Rocco on 7/31/16.
//  Copyright © 2016 Matthew Rocco. All rights reserved.
//

import UIKit

class AddFriendViewController: UIViewController {

    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var platformSelector: UISegmentedControl!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var regionSelector: UISegmentedControl!
    
    private var friends = [Friend]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = NSUserDefaults.standardUserDefaults().objectForKey("friends") as? NSData {
            friends = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! [Friend]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addFriend(sender: AnyObject) {
        friends.append(Friend(name: idTextField.text!, region: REGION_ARRAY[regionSelector.selectedSegmentIndex], platform: CONSOLE_ARRAY[platformSelector.selectedSegmentIndex]))
        let data = NSKeyedArchiver.archivedDataWithRootObject(friends)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "friends")
    }

}
