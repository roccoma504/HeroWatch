//
//  UserInfoViewController.swift
//  HeroWatch
//
//  Created by Matthew Rocco on 7/26/16.
//  Copyright © 2016 Matthew Rocco. All rights reserved.
//

import ChameleonFramework
import UIKit

class UserInfoViewController: UIViewController {
    
    @IBOutlet weak var battleTagLabel: UILabel!
    @IBOutlet weak var consoleLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var quickLabel: UILabel!
    @IBOutlet weak var rankedLabel: UILabel!
    @IBOutlet weak var quickImageView: UIImageView!
    @IBOutlet weak var rankedImageView: UIImageView!
    
    // Defines an instances of the user defaults.
    private let prefs = NSUserDefaults.standardUserDefaults()
    
    // Defines an enumeration denoting the type of images that are displayed.
    private enum imageKind {
        case avatar
        case ranked
    }
    
    // Defines images retrieved from the OW API.
    private var rankedImage, quickImage : UIImage!
    
    // Defines flags denoting corresponding data is ready from the server.
    private var avatarImageValid : Bool = false
    private var rankedImageValid : Bool = false
    
    // Defines a instances of the User class to allow retrieval of user
    // information from the server.
    private var userInfo : User!

    /**
     Updates a given UIImageView with some common format.
     - parameter view: The view to update.
     - parameter image: The image to update the view with.
     */
    private func update(view : UIImageView, image : UIImage) {
        dispatch_async(dispatch_get_main_queue(),{
            view.image = image
            view.layer.cornerRadius = view.frame.size.width / 2
            view.clipsToBounds = true
        })
    }
    
    /**
     Updates a given UIImageView with some common format.
     - parameter view: The view to update.
     - parameter text: The base text.
     - parameter prefix: A prefix for the text if needed.
     */
    private func update(view : UILabel, text : String, prefix : String = "") {
        dispatch_async(dispatch_get_main_queue(),{
            view.text = prefix + text.uppercaseString
        })
    }

    /**
     Updates all of the UI if all data has been retrieved.
     */
    private func update() {
        if avatarImageValid && rankedImageValid {
            UIUtilities.adjustAlpha(self.view, alpha: 1.0)
            self.update(battleTagLabel, text: prefs.stringForKey("id")!)
            self.update(regionLabel, text: prefs.stringForKey("region")!)
            self.update(consoleLabel, text: prefs.stringForKey("console")!)
            self.update(quickLabel, text: String(userInfo.get(.Level) as! Int), prefix: "QP: ")
            self.update(rankedLabel, text: userInfo.get(.Rank) as! String, prefix: "RP: ")
        }
    }
    
    /**
     Fetches an image from the server. Sets the corresponding data flag when the
     image is successfully retrieved. Will display an error if the download fails.
     - parameter url: The URL for the image.
     - parameter kind: The kind of image to search for.
     */
    private func fetchImage(url : String, kind : imageKind) {
        JSONUtilities.downloadImage(NSURL(string: url)!) { (image, error) in
            if error != nil {
                UIUtilities.displayAlert(self, title: "Error!", message: (error?.localizedDescription)!)
            }
            else {
                switch kind {
                case .avatar:
                    self.update(self.quickImageView, image: image)
                    self.avatarImageValid = true
                    
                case .ranked:
                    self.update(self.rankedImageView, image: image)
                    self.rankedImageValid = true
                }
                self.update()
            }
        }
    }
    
    /**
     Fetches user data from the server. When user data is retrived the user images
     are then also retrieved. Will display an error if the download fails.
     - parameter url: The URL for the image.
     - parameter kind: The kind of image to search for.
     */
    private func getUserData() {
        JSONUtilities.retrieve(URLUtilities.profileURL(prefs.stringForKey("console")!, region: prefs.stringForKey("region")!, userID: prefs.stringForKey("id")!)) { (json, error) in
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

    /**
     On load adjust the alpha to denote we are loading the page and begin
     retrieval of user data.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        UIUtilities.adjustAlpha(self.view, alpha: 0.5)
        self.view.backgroundColor = FlatGray()
        getUserData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
