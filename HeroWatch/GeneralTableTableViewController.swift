//
//  GeneralTableTableViewController.swift
//  HeroWatch
//
//  Created by Matthew Rocco on 8/6/16.
//  Copyright © 2016 Matthew Rocco. All rights reserved.
//

import ChameleonFramework
import UIKit

class GeneralTableTableViewController: UITableViewController {
    
    private var receivedData : Array <String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = FlatWhite()
        tableView.tableFooterView = UIView(frame: CGRect.zero)

        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadList:",name:"load", object: receivedData)
    }
    
    func loadList(notification: NSNotification){
        dispatch_async(dispatch_get_main_queue(), {
            let arrayObject =  notification.object as! [AnyObject]
            self.receivedData = arrayObject as! Array <String>
            self.tableView.reloadData()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if receivedData == nil {
            return 0
        }
        else {
            print (self.receivedData.count)
            return self.receivedData.count
        }
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! GeneralTableViewCell
        
        cell.labelOne.text = receivedData[indexPath.row]
        
        
        
        return cell
    }
    
    
}
