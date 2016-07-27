//
//  GraphViewController.swift
//  HeroWatch
//
//  Created by Matthew Rocco on 7/26/16.
//  Copyright © 2016 Matthew Rocco. All rights reserved.
//

import ChameleonFramework
import UIKit

class GraphViewController: UIViewController {
    
    @IBOutlet weak var circleOne: KDCircularProgress!
    @IBOutlet weak var circleTwo: KDCircularProgress!
    @IBOutlet weak var circleThree: KDCircularProgress!
    
    
    private var userInfo : User!
    
    private let prefs = NSUserDefaults.standardUserDefaults()


    
    private enum GraphKind : Int {
        case Wins = 0
        case Kills
    }

    
    // create swipe gesture
    let swipeGestureLeft = UISwipeGestureRecognizer()
    let swipeGestureRight = UISwipeGestureRecognizer()
    
    private var currentGraphKind : GraphKind = .Wins
    
    
    // outlet - page control
    @IBOutlet var myPageControl: UIPageControl!
    

    private func displaycircle (circle : KDCircularProgress, toAngle : Int, color : UIColor, zPos: CGFloat) {
        circle.animateFromAngle(0, toAngle: toAngle , duration: 4.0, completion: nil)
        circle.layer.zPosition = zPos
        circle.setColors(color)
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
                self.update(.Wins)

            }
        }
    }
    
    private func update(kind : GraphKind) {
        
        let quickAngles = CircleAngles(valueOne: self.userInfo.get(.QW) as! String, valueTwo: self.userInfo.get(.QL) as! String)
        let colors = ColorSchemeOf(.Triadic, color: PRIMARY_COLOR, isFlatScheme: true)
        
        displaycircle(circleOne, toAngle: quickAngles.get(.EndOne), color: colors[0], zPos: 2)
        displaycircle(circleTwo, toAngle: quickAngles.get(.EndTwo), color: colors[1], zPos: 1)
    }

    
    // MARK: - view functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //getUserData()
        // Do any additional setup after loading the view, typically from a nib.

        
        // set gesture direction
        swipeGestureLeft.direction = UISwipeGestureRecognizerDirection.Left
        swipeGestureRight.direction = UISwipeGestureRecognizerDirection.Right
        
        // add gesture target
        swipeGestureLeft.addTarget(self, action: #selector(GraphViewController.handleSwipeLeft(_:)))
        swipeGestureRight.addTarget(self, action: #selector(GraphViewController.handleSwipeRight(_:)))
        
        // add gesture in to view
        view.addGestureRecognizer(swipeGestureLeft)
        view.addGestureRecognizer(swipeGestureRight)
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Utility function
    
    // increase page number on swift left
    func handleSwipeLeft(gesture: UISwipeGestureRecognizer){
        if self.myPageControl.currentPage < 9 {
            self.myPageControl.currentPage += 1
            update(GraphKind(rawValue: self.myPageControl.currentPage)!)
        }
    }
    
    // reduce page number on swift right
    func handleSwipeRight(gesture: UISwipeGestureRecognizer){
        
        if self.myPageControl.currentPage != 0 {
            self.myPageControl.currentPage -= 1
            update(GraphKind(rawValue: self.myPageControl.currentPage)!)
        }
    }


}
