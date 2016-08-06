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
    
    private enum GraphKind : Int {
        case Wins = 0
        case Kills
    }
    
    private let prefs = NSUserDefaults.standardUserDefaults()
    
    var colors = [UIColor]()
    
    private var userInfo : User!
    private var quickAllHeroes : AllHeroes!
    private var compAllHeroes : AllHeroes!
    private var userIsReady = false
    private var quickIsReady = false
    private var compIsReady = false


    // create swipe gesture
    let swipeGestureLeft = UISwipeGestureRecognizer()
    let swipeGestureRight = UISwipeGestureRecognizer()
    
    private var currentGraphKind : GraphKind = .Wins
    
    // outlet - page control
    @IBOutlet var pageControl: UIPageControl!
    
    private func update() {
        if userIsReady && compIsReady && quickIsReady {
        self.update(.Wins)
        }
    }
    

    
    
    private func displaycircle (circle : KDCircularProgress, fromAngle : Int, toAngle : Int, color : UIColor, zPos: CGFloat) {
        circle.animateFromAngle(0, toAngle: toAngle , duration: 4.5, completion: nil)
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
                print(json)
                self.userInfo = User(JSON: json)
                self.userIsReady = true
                self.update()
            }
        }
        
        
        JSONUtilities.retrieve(URLUtilities.quickPlayURL(prefs.stringForKey("console")!, region: prefs.stringForKey("region")!, userID: prefs.stringForKey("id")!)) { (json, error) in
            // If we successfully retrieved
            if error != nil {
                UIUtilities.displayAlert(self, title: "Error!", message: (error?.localizedDescription)!)
            }
            else {
                print(json)
                self.quickAllHeroes = AllHeroes(JSON: json)
                self.quickIsReady = true
                self.update()


            }
        }
        
        JSONUtilities.retrieve(URLUtilities.compPlayURL(prefs.stringForKey("console")!, region: prefs.stringForKey("region")!, userID: prefs.stringForKey("id")!)) { (json, error) in
            // If we successfully retrieved
            if error != nil {
                UIUtilities.displayAlert(self, title: "Error!", message: (error?.localizedDescription)!)
            }
            else {
                print(json)
                self.compAllHeroes = AllHeroes(JSON: json)
                self.compIsReady = true
                self.update()


            }
        }


        
    }
    
    private func update(kind : GraphKind) {
        let angles : CircleAngles!
        
        
        var hideThree = false
        var hideFour = false
        var labels : Array<String> = []
        
        UIUtilities.adjustActivity(activityView, stop: true)
        
        circleThree.hidden = true
        circleFour.hidden = true
  

        switch kind {
        case .Wins:
            angles = CircleAngles(valueOne: self.userInfo.get(.QW) as! String, valueTwo: self.userInfo.get(.QL) as! String, labelOne: "Win", labelTwo: "Lose")
            
            hideThree = true
            hideFour = true

        case .Kills:
            angles = CircleAngles(valueOne: self.quickAllHeroes.get(.Eliminations) as! String, valueTwo: self.quickAllHeroes.get(.Deaths) as! String, valueThree: self.compAllHeroes.get(.Eliminations) as! String, valueFour: self.compAllHeroes.get(.Deaths) as! String, labelOne: "Quickplay Eliminations", labelTwo: "Quickplay Deaths", labelThree: "Competitive Eliminations", labelFour: "Competitive Deaths")
        }
        
        dispatch_async(dispatch_get_main_queue(), {
            
            self.displaycircle(self.circleOne,fromAngle: 0, toAngle: angles.get(.EndOne), color: self.colors[1], zPos: 3)
            self.displaycircle(self.circleTwo, fromAngle: angles.get(.EndOne), toAngle: angles.get(.EndTwo), color: self.colors[2], zPos: 2)
            self.summaryLabel.text = "Total : " + String(angles.get(.Total))
            
            
            labels.append(angles.get(.LabelOne))
            labels.append(angles.get(.LabelTwo))
            
            if !hideThree {
                self.displaycircle(self.circleThree,fromAngle: angles.get(.EndTwo), toAngle: angles.get(.EndThree), color: self.colors[3], zPos: 1)
                self.circleThree.hidden = false
                labels.append(angles.get(.LabelThree))
            }
            
            if !hideFour {
                self.displaycircle(self.circleFour,fromAngle: angles.get(.EndThree), toAngle: angles.get(.EndFour), color: self.colors[0], zPos: 0)
                self.circleFour.hidden = false
                labels.append(angles.get(.LabelFour))
            }
            
            NSNotificationCenter.defaultCenter().postNotificationName("load", object: labels)


        })
    }
    
    
    // MARK: - view functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colors = ColorSchemeOf(.Analogous, color: SECONDARY_COLOR, isFlatScheme: true)
        activityView.color = colors[4]
        pageControl.numberOfPages = GraphKind.Kills.rawValue + 1
        pageControl.tintColor = self.colors[4]
        view.backgroundColor = FlatWhite()
        
        
        
        getUserData()
        
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
