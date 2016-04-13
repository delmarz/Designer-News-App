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
  var comments: JSON!
  
  override func viewDidLoad() {
    super.viewDidLoad()
        comments = story["comments"]
        print(comments.count)
  }
  
  //MARK:
  //MARK: TableView DataSource
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5//comments.count + 1
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let identifier = indexPath.row == 0 ? "StoryCell" : "CommentCell"
    let cell = tableView.dequeueReusableCellWithIdentifier(identifier)! as UITableViewCell
    if let storyCell = cell as? StoryTableViewCell {
         storyCell.configureWithStory(story)
    }
    
    if let commentCell = cell as? CommentTableViewCell {
        let comment = comments[indexPath.row-1]
        commentCell.configureWithComment(comment)
    }
    
    return cell
  }
 
}
