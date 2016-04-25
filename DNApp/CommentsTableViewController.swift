//
//  CommentsTableViewController.swift
//  DNApp
//
//  Created by Kryptonite on 4/12/16.
//  Copyright © 2016 Kryptonite. All rights reserved.
//

import UIKit

class CommentsTableViewController: UITableViewController, CommentTableViewCellDelegate, StoryTableViewCellDelegate{

  var story: JSON!
  var comments: JSON!
  
  override func viewDidLoad() {
    super.viewDidLoad()
        comments = story["comments"]
        print(comments.count)
    
    tableView.estimatedRowHeight = 100
    tableView.rowHeight = UITableViewAutomaticDimension
  }
  
  //MARK:
  //MARK: TableView DataSource
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return comments.count + 1
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let identifier = indexPath.row == 0 ? "StoryCell" : "CommentCell"
    let cell = tableView.dequeueReusableCellWithIdentifier(identifier)! as UITableViewCell
    
    if let storyCell = cell as? StoryTableViewCell {
      storyCell.configureWithStory(story)
      storyCell.delegate = self
    }
    
    if let commentCell = cell as? CommentTableViewCell {
      let comment = comments[indexPath.row-1]
      commentCell.configureWithComment(comment)
      commentCell.delegate = self
    }
    
    return cell
  }
  
  //MARK:
  //MARK: CommentTableViewCell Delegate
  func commentTableViewCellDidPressUpvote(cell: CommentTableViewCell) {
    if let token = LocalStore.getToken() {
      let indexPath = tableView.indexPathForCell(cell)!
      let comment = comments[indexPath.row-1]
      let commentId = comment["id"].int!
      LocalStore.saveUpvotedComment(commentId)
      cell.configureWithComment(comment)
      DNService.upvoteCommentWithId(commentId, token: token, response: { (successful) in
        // do something
      })
    } else {
      performSegueWithIdentifier("LoginSegue", sender: self)
    }
  }
  
  func commentTableViewCellDidPressedComment(cell: CommentTableViewCell) {
    
  }
  
  //MARK:
  //MARK: StoryTableViewCell Delegate
  func storyTableViewCellDidPressedUpVote(cell: StoryTableViewCell, sender: AnyObject) {
    if let token = LocalStore.getToken() {
      let storyId = story["id"].int!
      DNService.upvoteStoryWithId(storyId, token: token, response: { (successful) in
        // Do something
      })
      LocalStore.saveUpvotedStory(storyId)
      cell.configureWithStory(story)
    } else {
      performSegueWithIdentifier("LoginSegue", sender: self)
    }
  }
  
  func storyTableViewCellDidPressedComment(cell: StoryTableViewCell, sender: AnyObject) {
    
  }
  
  
  
}
