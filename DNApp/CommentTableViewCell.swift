//
//  CommentTableViewCell.swift
//  DNApp
//
//  Created by Kryptonite on 4/12/16.
//  Copyright © 2016 Kryptonite. All rights reserved.
//

import UIKit

protocol CommentTableViewCellDelegate: class {
  func commentTableViewCellDidPressUpvote(cell: CommentTableViewCell)
  func commentTableViewCellDidPressedComment(cell: CommentTableViewCell)
}

class CommentTableViewCell: UITableViewCell {

  weak var delegate: CommentTableViewCellDelegate?
  @IBOutlet weak var authorLabel: UILabel!
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var upvoteButton: SpringButton!
  @IBOutlet weak var replyButton: SpringButton!
  @IBOutlet weak var commentTextView: AutoTextView!
  @IBOutlet weak var avatarImageView: AsyncImageView!
  @IBOutlet weak var avatarLeftConstraint: NSLayoutConstraint!
  
    @IBOutlet weak var indentView: UIView!
  @IBAction func upvoteButtonDidPressed(sender: AnyObject) {
    SoundPlayer.play("upvote.wav")
    upvoteButton.animation = "pop"
    upvoteButton.force = 3
    upvoteButton.animate()
    delegate?.commentTableViewCellDidPressUpvote(self)
  }
  
  @IBAction func replyButtonDidPressed(sender: AnyObject) {
    replyButton.animation = "pop"
    replyButton.force = 3
    replyButton.animate()
    delegate?.commentTableViewCellDidPressedComment(self)
  }
  
  func configureWithComment(comment: JSON) {
    let userDisplayName = comment["user_display_name"].string ?? ""
    let userJob = comment["user_job"].string ?? ""
    let createdAt = comment["created_at"].string ?? ""
    let voteCount = comment["vote_count"].int!
    //let body = comment["body"].string ?? ""
    let bodyHTML = comment["body_html"].string ?? ""
    
    let userPortraitUrl = comment["user_portrait_url"].string
    avatarImageView.url = userPortraitUrl?.toURL()
      
    avatarImageView.placeholderImage = UIImage(named: "content-avatar-default")
    authorLabel.text = userDisplayName + "," + userJob
    timeLabel.text = timeAgoSinceDate(dateFromString(createdAt, format: "yyyy-MM-dd'T'HH:mm:ssZ"), numericDates: true)
    //commentTextView.text = body
    commentTextView.attributedText = htmlToAttributedString(bodyHTML + "<style>*{font-family:\"Avenir Next\";font-size:16px;line-height:20px}img{max-width:300px}</style>")
    
    let commentId = comment["id"].int!
    if LocalStore.isCommentUpvoted(commentId) {
      upvoteButton.setImage(UIImage(named: "icon-upvote-active"), forState: UIControlState.Normal)
      upvoteButton.setTitle(String(voteCount+1), forState: UIControlState.Normal)
    } else {
      upvoteButton.setImage(UIImage(named: "icon-upvote"), forState: UIControlState.Normal)
      upvoteButton.setTitle(String(voteCount), forState: UIControlState.Normal)
    }
   
    let depth = comment["depth"].int! > 4 ? 4 : comment["depth"].int!
    if depth > 0 {
        avatarLeftConstraint.constant = CGFloat(depth) * 20 + 25
        separatorInset = UIEdgeInsets(top: 0, left: CGFloat(depth) * 20 + 15, bottom: 0, right: 0)
        indentView.hidden = false
    } else {
        avatarLeftConstraint.constant = 10
        separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        indentView.hidden = true
    }
  }
}
