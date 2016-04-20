//
//  CommentTableViewCell.swift
//  DNApp
//
//  Created by Kryptonite on 4/12/16.
//  Copyright © 2016 Kryptonite. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

  
  @IBOutlet weak var authorLabel: UILabel!
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var upvoteButton: SpringButton!
  @IBOutlet weak var replyButton: SpringButton!
  @IBOutlet weak var commentTextView: AutoTextView!
  @IBOutlet weak var avatarImageView: AsyncImageView!
  
  @IBAction func upvoteButtonDidPressed(sender: AnyObject) {
  }
  
  @IBAction func replyButtonDidPressed(sender: AnyObject) {
  }
  
  func configureWithComment(comment: JSON) {
    let userDisplayName = comment["user_display_name"].string ?? ""
    let userJob = comment["user_job"].string ?? ""
    let createdAt = comment["created_at"].string ?? ""
    let voteCount = comment["vote_count"].int!
    let body = comment["body"].string ?? ""    
    let bodyHTML = comment["body_html"].string ?? ""
    
    let userPortraitUrl = comment["user_portrait_url"].string
    avatarImageView.url = userPortraitUrl?.toURL()
      
    avatarImageView.placeholderImage = UIImage(named: "content-avatar-default")
    authorLabel.text = userDisplayName + "," + userJob
    timeLabel.text = timeAgoSinceDate(dateFromString(createdAt, format: "yyyy-MM-dd'T'HH:mm:ssZ"), numericDates: true)
    upvoteButton.setTitle(String(voteCount), forState: UIControlState.Normal)
    commentTextView.text = body
    commentTextView.attributedText = htmlToAttributedString(bodyHTML + "<style>*{font-family:\"Avenir Next\";font-size:16px;line-height:20px}img{max-width:300px}</style>")
  }
}
