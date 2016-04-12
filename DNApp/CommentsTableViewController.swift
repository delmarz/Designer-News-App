//
//  CommentsTableViewController.swift
//  DNApp
//
//  Created by Kryptonite on 4/12/16.
//  Copyright © 2016 Kryptonite. All rights reserved.
//

import UIKit

class CommentsTableViewController: UITableViewController {

  var story: JSON!
  var comment: JSON!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    comment = story["comments"]
    
    print("\(comment.count)")
  }
  
  //MARK:
  //MARK: TableView DataSource
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return comment.count + 1
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let identifier = indexPath.row == 0 ? "StoryCell" : "CommentCell"
    let cell = tableView.dequeueReusableCellWithIdentifier(identifier)! as UITableViewCell
    if let storyCell = cell as? StoryTableViewCell {
         storyCell.configureWithStory(story)
    }
    
    if let commentCell = cell as? CommentTableViewCell {
        commentCell.configureWithComment(comment)
    }
    return cell
  }
 
}
