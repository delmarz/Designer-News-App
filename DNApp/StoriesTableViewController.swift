//
//  StoriesTableViewController.swift
//  DNApp
//
//  Created by Shadez Prado on 03/04/2016.
//  Copyright © 2016 Kryptonite. All rights reserved.
//

import UIKit

class StoriesTableViewController: UITableViewController {
    
    //MARK: 
    //MARK: IBAction
    @IBAction func menuBarButtonItemPressed(sender: AnyObject) {
        performSegueWithIdentifier("MenuSegue", sender: self)
    }
    
    @IBAction func loginBarButtonItemPressed(sender: AnyObject) {
        performSegueWithIdentifier("LoginSegue", sender: self)
    }
    
    //MARK:
    //MARK: TableViewDataSource
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("StoryCell") as UITableViewCell!
        return cell
    }
    
    //MARK:
    //MARK: TableViewDelegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        performSegueWithIdentifier("WebSegue", sender: self)
    }
    
}
