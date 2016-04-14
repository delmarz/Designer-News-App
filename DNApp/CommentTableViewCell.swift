//
//  CommentTableViewCell.swift
//  DNApp
//
//  Created by Kryptonite on 4/12/16.
//  Copyright © 2016 Kryptonite. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

  
  @IBOutlet weak var avatarImageView: UIImageView!
  @IBOutlet weak var authorLabel: UILabel!
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var upvoteButton: SpringButton!
  @IBOutlet weak var replyButton: SpringButton!
  @IBOutlet weak var commentTextView: AutoTextView!
  
  @IBAction func upvoteButtonDidPressed(sender: AnyObject) {
  }
  
  @IBAction func replyButtonDidPressed(sender: AnyObject) {
  }
  
  func configureWithComment(comment: JSON) {
    //let userPortraitUrl = comment["user_portrairt_url"].string!
    let userDisplayName = comment["user_display_name"].string!
    let userJob = comment["user_job"].string!
    let createdAt = comment["created_at"].string!
    let voteCount = comment["vote_count"].int!
    let body = comment["body"].string!
    
    authorLabel.text = userDisplayName + "," + userJob
    timeLabel.text = timeAgoSinceDate(dateFromString(createdAt, format: "yyyy-MM-dd'T'HH:mm:ssZ"), numericDates: true)
    upvoteButton.setTitle(String(voteCount), forState: UIControlState.Normal)
    commentTextView.text = body
    
    
    
    
  }
}
