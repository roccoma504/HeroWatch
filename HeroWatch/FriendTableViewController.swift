//
//  FriendTableViewController.swift
//
//
//  Created by Matthew Rocco on 7/30/16.
//
//

import UIKit

class FriendTableViewController: UITableViewController {
    
    private var friends = [Friend]()
    
    @objc private func reload() {
        if let data = NSUserDefaults.standardUserDefaults().objectForKey("friends") as? NSData {
            friends = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! [Friend]
            print(friends)
        }
        tableView.reloadData()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(add))
        self.refreshControl?.addTarget(self, action: #selector(reload), forControlEvents: UIControlEvents.ValueChanged)
        reload()
    }
    
    override func viewDidAppear(animated: Bool) {
        reload()
    }
    
    @objc private func add () {
        performSegueWithIdentifier("addFriend", sender: self)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return friends.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            friends.removeAtIndex(indexPath.row)
            let data = NSKeyedArchiver.archivedDataWithRootObject(friends)
            NSUserDefaults.standardUserDefaults().setObject(data, forKey: "friends")
            reload()

        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == friends.count - 1 {
            refreshControl!.endRefreshing()
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! FriendTableViewCell
        
        cell.battleTag.text = friends[indexPath.row].get(.Name)
        
        return cell
    }
    
}
