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
    @IBOutlet weak var circleFour: KDCircularProgress!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    
    private enum GraphKind : Int {
        case Wins = 0
        case Kills
        case Damage
        case Medals
    }
    
    private let prefs = NSUserDefaults.standardUserDefaults()
    
    private var stat : StatKind = .Quick
    private var userInfo : User!
    private var quickAllHeroes : AllHeroes!
    private var compAllHeroes : AllHeroes!
    private var userIsReady = false
    private var quickIsReady = false
    private var compIsReady = false
    private var isQuick = true
    private var isErrored = false
    
    // create swipe gesture
    let swipeGestureLeft = UISwipeGestureRecognizer()
    let swipeGestureRight = UISwipeGestureRecognizer()
    
    private var currentGraphKind : GraphKind = .Wins
    
    // outlet - page control
    @IBOutlet var pageControl: UIPageControl!
    
    private func checkReady(kind : GraphKind) {
        if isErrored {
            dispatch_async(dispatch_get_main_queue(), {
                UIUtilities.displayAlert(self, title: "Error!", message: "Unknown error. Please try again later.")
                UIUtilities.adjustActivity(self.activityView, stop: true)
                UIUtilities.adjustAlpha(self.view, alpha: 1.0)
                self.errorLabel.hidden = false
                self.pageControl.hidden = true
            })
            
        }
        else if userIsReady && compIsReady && quickIsReady {
            self.update(kind)
        }
    }
    
    private func update(text : String) {
        dispatch_async(dispatch_get_main_queue(), {
            self.summaryLabel.text = text
        })
        
    }
    
    private func displaycircle (circle : KDCircularProgress, fromAngle : Int, toAngle : Int, color : UIColor, zPos: CGFloat) {
        circle.animateFromAngle(0, toAngle: toAngle , duration: 1.0, completion: nil)
        circle.layer.zPosition = zPos
        circle.setColors(color)
    }
    
    private func getUserData() {
        
        errorLabel.hidden = true
        
        // Retrieve the JSON for the user configuration.
        JSONUtilities.retrieve(URLUtilities.profileURL(prefs.stringForKey("console")!, region: prefs.stringForKey("region")!, userID: prefs.stringForKey("id")!)) { (json, error) in
            // If we successfully retrieved
            if error != nil {
                UIUtilities.displayAlert(self, title: "Error!", message: (error?.localizedDescription)!)
                self.userIsReady = true
                self.isErrored = true
                self.checkReady(.Wins)
            }
            else {
                self.userInfo = User(JSON: json)
                self.userIsReady = true
                self.checkReady(.Wins)
                
            }
        }
        
        
        JSONUtilities.retrieve(URLUtilities.quickPlayURL(prefs.stringForKey("console")!, region: prefs.stringForKey("region")!, userID: prefs.stringForKey("id")!)) { (json, error) in
            // If we successfully retrieved
            if error != nil {
                UIUtilities.displayAlert(self, title: "Error!", message: (error?.localizedDescription)!)
                self.userIsReady = true
                self.isErrored = true
                self.checkReady(.Wins)
            }
            else {
                self.quickAllHeroes = AllHeroes(JSON: json)
                self.quickIsReady = true
                self.checkReady(.Wins)
            }
        }
        
        JSONUtilities.retrieve(URLUtilities.compPlayURL(prefs.stringForKey("console")!, region: prefs.stringForKey("region")!, userID: prefs.stringForKey("id")!)) { (json, error) in
            // If we successfully retrieved
            if error != nil {
                UIUtilities.displayAlert(self, title: "Error!", message: (error?.localizedDescription)!)
                self.isErrored = true
                self.compIsReady = true
                self.checkReady(.Wins)
            }
            else {
                self.compAllHeroes = AllHeroes(JSON: json)
                self.compIsReady = true
                self.checkReady(.Wins)
            }
        }
    }
    
    private func update(kind : GraphKind) {
        let angles : CircleAngles!
        
        var labels : Array<String> = []
        var displayThree = false
        
        switch kind {
        case .Wins:
            if isQuick {
                angles = CircleAngles(valueOne: self.userInfo.get(.QW) as! String, valueTwo: self.userInfo.get(.QL) as! String, labelOne: "Win", labelTwo: "Lost")
            }
            else {
                angles = CircleAngles(valueOne: self.userInfo.get(.CW) as! String, valueTwo: self.userInfo.get(.CL) as! String, labelOne: "Win", labelTwo: "Lost")
            }
            
            update(String(angles.get(.Total)).addComma())
            
            
        case .Kills:
            if isQuick {
                angles = CircleAngles(valueOne: self.quickAllHeroes.get(.Eliminations) as! String, valueTwo: self.quickAllHeroes.get(.Deaths) as! String, labelOne: "Eliminations", labelTwo: "Deaths")
                
                update(String(String(Float(self.quickAllHeroes.get(.Eliminations) as! String)!/Float(self.quickAllHeroes.get(.Deaths) as! String)!)))
            }
            else {
                angles = CircleAngles(valueOne: self.compAllHeroes.get(.Eliminations) as! String, valueTwo: self.compAllHeroes.get(.Deaths) as! String, labelOne: "Eliminations", labelTwo: "Deaths")
                
                update(String(String(Float(self.compAllHeroes.get(.Eliminations) as! String)!/Float(self.compAllHeroes.get(.Deaths) as! String)!)))
            }
            
        case .Damage:
            if isQuick {
                angles = CircleAngles(valueOne: self.quickAllHeroes.get(.Damage) as! String, valueTwo: self.quickAllHeroes.get(.Healing) as! String, labelOne: "Damage", labelTwo: "Healing")
            }
            else {
                angles = CircleAngles(valueOne: self.compAllHeroes.get(.Damage) as! String, valueTwo: self.compAllHeroes.get(.Healing) as! String, labelOne: "Damage", labelTwo: "Healing")
            }
            
            update(String(angles.get(.Total)).addComma())
            
        case .Medals:
            
            displayThree = true
            if isQuick {
                angles = CircleAngles(valueOne: self.quickAllHeroes.get(.Gold) as! String, valueTwo: self.quickAllHeroes.get(.Silver) as! String, valueThree: self.quickAllHeroes.get(.Bronze) as! String, labelOne: "Gold", labelTwo: "Silver", labelThree: "Bronze")
            }
            else {
                angles = CircleAngles(valueOne: self.compAllHeroes.get(.Gold) as! String, valueTwo: self.compAllHeroes.get(.Silver) as! String, valueThree: self.compAllHeroes.get(.Bronze) as! String, labelOne: "Gold", labelTwo: "Silver", labelThree: "Bronze")
            }
            update(String(angles.get(.Total)).addComma())
        }
        
        dispatch_async(dispatch_get_main_queue(), {
            self.displaycircle(self.circleOne,fromAngle: 0, toAngle: angles.get(.EndOne), color: colors[2], zPos: 3)
            self.displaycircle(self.circleTwo, fromAngle: angles.get(.EndOne), toAngle: angles.get(.EndTwo), color: colors[1], zPos: 2)
            self.displaycircle(self.circleThree,fromAngle: angles.get(.EndTwo), toAngle: angles.get(.EndThree), color: colors[0], zPos: 1)
            
            labels.append(angles.get(.LabelOne))
            labels.append(angles.get(.LabelTwo))
            
            if displayThree {
                labels.append(angles.get(.LabelThree))
            }
            
            UIUtilities.adjustActivity(self.activityView, stop: true)
            UIUtilities.adjustAlpha(self.view, alpha: 1.0)
            
            NSNotificationCenter.defaultCenter().postNotificationName("load", object: labels)
            
            self.pageControl.enabled = true
            self.pageControl.hidden = false
            
            if self.isQuick {
                if let level = self.userInfo.get(.Level) as? Int {
                    self.levelLabel.text = "Quick Play : " + String(level)
                    UIUtilities.hideView(self.levelLabel, hide: false)
                }
            }
            else {
                if let rank = self.userInfo.get(.Rank) as? String {
                    self.levelLabel.text = "Competitive Play : " + String(rank)
                    UIUtilities.hideView(self.levelLabel, hide: false)
                }
            }
        })
    }
    
    func switchType(notification: NSNotification){
        dispatch_async(dispatch_get_main_queue(), {
            self.isQuick =  notification.object as! Bool
            self.checkReady(GraphKind(rawValue: self.pageControl.currentPage)!)
        })
    }
    
    func reload(notification: NSNotification){
        dispatch_async(dispatch_get_main_queue(), {
            UIUtilities.adjustAlpha(self.view, alpha: 0.5)
            UIUtilities.adjustActivity(self.activityView, stop: false)
            self.getUserData()
            self.pageControl.numberOfPages = GraphKind.Medals.rawValue + 1
            self.pageControl.enabled = false
            self.pageControl.currentPage = 0
            UIUtilities.hideView(self.levelLabel, hide: true)
            
            
        })
    }
    
    // MARK: - view functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set gesture direction
        swipeGestureLeft.direction = UISwipeGestureRecognizerDirection.Left
        swipeGestureRight.direction = UISwipeGestureRecognizerDirection.Right
        
        // add gesture target
        swipeGestureLeft.addTarget(self, action: #selector(GraphViewController.handleSwipeLeft(_:)))
        swipeGestureRight.addTarget(self, action: #selector(GraphViewController.handleSwipeRight(_:)))
        
        // add gesture in to view
        view.addGestureRecognizer(swipeGestureLeft)
        view.addGestureRecognizer(swipeGestureRight)
        
        pageControl.enabled = false
    }
    
    override func viewDidAppear(animated: Bool) {
        activityView.color = PRIMARY_COLOR
        pageControl.numberOfPages = GraphKind.Medals.rawValue + 1
        pageControl.tintColor = PRIMARY_COLOR
        view.backgroundColor = FlatWhite()
        UIUtilities.adjustAlpha(view, alpha: 0.5)
        UIUtilities.hideView(levelLabel, hide: true)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "switchType:",name:"switch", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reload:",name:"reload", object: nil)
        
        
        getUserData()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Utility function
    
    // increase page number on swift left
    func handleSwipeLeft(gesture: UISwipeGestureRecognizer){
        if self.pageControl.currentPage < self.pageControl.numberOfPages - 1 {
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
