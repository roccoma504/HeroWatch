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
    
    // Defines our circles for data viewing.
    @IBOutlet weak var circleOne: KDCircularProgress!
    @IBOutlet weak var circleTwo: KDCircularProgress!
    @IBOutlet weak var circleThree: KDCircularProgress!
    @IBOutlet weak var oneLabel: UILabel!
    @IBOutlet weak var twoLabel: UILabel!
    @IBOutlet weak var threeLabel: UILabel!
    
    private enum GraphKind : Int {
        case Wins = 0
        case Kills
    }
    
    private let prefs = NSUserDefaults.standardUserDefaults()
    
    var colors = [UIColor]()

    private var userInfo : User!
    
    // create swipe gesture
    let swipeGestureLeft = UISwipeGestureRecognizer()
    let swipeGestureRight = UISwipeGestureRecognizer()
    
    private var currentGraphKind : GraphKind = .Wins
    
    // outlet - page control
    @IBOutlet var pageControl: UIPageControl!
    
    private func displaycircle (circle : KDCircularProgress, toAngle : Int, color : UIColor, zPos: CGFloat) {
        circle.animateFromAngle(0, toAngle: toAngle , duration: 2.5, completion: nil)
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
        
        threeLabel.hidden = true
        circleThree.hidden = true
        
        let angles : CircleAngles!
        
        //let angles = CircleAngles(valueOne: self.userInfo.get(.QW) as! String, valueTwo: self.userInfo.get(.QL) as! String, labelOne: "", labelTwo: "")
        
        
        if kind == .Wins {
            
            angles = CircleAngles(valueOne: "180", valueTwo: "180", labelOne: "One", labelTwo: "Two")
            
        }
        else {
            angles = CircleAngles(valueOne: "120", valueTwo: "120", valueThree: "120", labelOne: "One", labelTwo: "Two", labelThree: "Three")
            
        }
        view.backgroundColor = colors[0]
        displaycircle(circleOne, toAngle: angles.get(.EndOne), color: colors[1], zPos: 2)
        displaycircle(circleTwo, toAngle: angles.get(.EndTwo), color: colors[2], zPos: 1)
        pageControl.tintColor = colors[4]
        oneLabel.text = angles.get(.LabelOne).uppercaseString
        oneLabel.textColor = colors[1]
        twoLabel.text = angles.get(.LabelTwo).uppercaseString
        twoLabel.textColor = colors[2]
        
        if kind != .Wins {
            displaycircle(circleThree, toAngle: angles.get(.EndThree), color: colors[3], zPos: 0)
            threeLabel.text = angles.get(.LabelThree).uppercaseString
            threeLabel.textColor = colors[3]
            threeLabel.hidden = false
            circleThree.hidden = false
        }
    }
    
    
    // MARK: - view functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        colors = ColorSchemeOf(.Analogous, color: SECONDARY_COLOR, isFlatScheme: true)

        
        //getUserData()
        // Do any additional setup after loading the view, typically from a nib.
        
        update(.Wins)
        
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
        if self.pageControl.currentPage < 9 {
            self.pageControl.currentPage += 1
            update(GraphKind(rawValue: self.pageControl.currentPage)!)
        }
    }
    
    // reduce page number on swift right
    func handleSwipeRight(gesture: UISwipeGestureRecognizer){
        
        if self.pageControl.currentPage != 0 {
            self.pageControl.currentPage -= 1
            update(GraphKind(rawValue: self.pageControl.currentPage)!)
        }
    }
    
    
}
