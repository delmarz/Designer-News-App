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
    return 1//data.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("StoryCell") as! StoryTableViewCell
//    let story = data[indexPath.row]
//    let title = story["title"] as! String
//    let badge = story["badge"] as! String
//    //let userPortraitUrl = story["user_portrait_url"] as! String
//    let userDisplayName = story["user_display_name"] as! String
//    let userJob = story["user_job"] as! String
//    let createdAt = story["create_at"] as! String
//    let voteCount = story["vote_count"] as! Int
//    let commentCount = story["comment_count"] as! Int
//    
//    cell.titleLabel.text = title
//    cell.badgeImageView.image = UIImage(named: "badge-" + badge)
//    cell.avatarImageView.image = UIImage(named: "content-avatar-default")
//    cell.authorLabel.text = userDisplayName + "," + userJob
//    cell.timeLabel.text = timeAgoSinceDate(dateFromString(createdAt, format: "yyyy-MM-dd'T'HH:mm:ssZ"), numericDates: true)
//    cell.upVoteButton.setTitle(String(voteCount), forState: UIControlState.Normal)
//    cell.commentbutton.setTitle(String(commentCount), forState: UIControlState.Normal)
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
