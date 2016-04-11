//
//  StoriesTableViewController.swift
//  DNApp
//
//  Created by Shadez Prado on 03/04/2016.
//  Copyright © 2016 Kryptonite. All rights reserved.
//

import UIKit

class StoriesTableViewController: UITableViewController, StoryTableViewCellDelegate{
  
  
  //MARK:
  //MARK: IBAction
  @IBAction func menuBarButtonItemPressed(sender: AnyObject) {
    performSegueWithIdentifier("MenuSegue", sender: self)
  }
  
  @IBAction func loginBarButtonItemPressed(sender: AnyObject) {
    performSegueWithIdentifier("LoginSegue", sender: self)
  }
  
  //MARK:
  //MARK: View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.estimatedRowHeight = 100
    tableView.rowHeight = UITableViewAutomaticDimension
  }
  
  //MARK:
  //MARK: TableViewDataSource
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("StoryCell") as! StoryTableViewCell
    cell.titleLabel.text = "Learn iOS Design Design and XcoDesign and XcoDesign and XcoDesign and XcoDesign and Xcoand Xcode"
    cell.badgeImageView.image = UIImage(named: "badge-apple")
    cell.avatarImageView.image = UIImage(named: "content-avatar-default")
    cell.authorLabel.text = "Israel Mayor, iOS Developer and Unity"
    cell.timeLabel.text = "5m"
    cell.upVoteButton.setTitle("32", forState: UIControlState.Normal)
    cell.commentbutton.setTitle("13", forState: UIControlState.Normal)
    cell.delegate = self
    return cell
  }
  
  //MARK:
  //MARK: TableViewDelegate
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    performSegueWithIdentifier("WebSegue", sender: self)
  }
  
  //MARK:
  //MARK: StoryTableViewCellDelegate
  func storyTableViewCellDidPressedUpVote(cell: StoryTableViewCell, sender: AnyObject) {
    print("up vote")
  }
  
  func storyTableViewCellDidPressedComment(cell: StoryTableViewCell, sender: AnyObject) {
    print("comment")
    performSegueWithIdentifier("CommentSegue", sender: cell)
  }
  
  
}
