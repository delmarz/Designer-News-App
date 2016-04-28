//
//  StoryTableViewCell.swift
//  DNApp
//
//  Created by Shadez Prado on 03/04/2016.
//  Copyright © 2016 Kryptonite. All rights reserved.
//

import UIKit

protocol StoryTableViewCellDelegate: class {
  func storyTableViewCellDidPressedUpVote(cell: StoryTableViewCell, sender: AnyObject)
  func storyTableViewCellDidPressedComment(cell: StoryTableViewCell, sender: AnyObject)
}

class StoryTableViewCell: UITableViewCell {
  weak var delegate: StoryTableViewCellDelegate?
  @IBOutlet weak var badgeImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var authorLabel: UILabel!
  @IBOutlet weak var upVoteButton: SpringButton!
  @IBOutlet weak var commentbutton: SpringButton!
  @IBOutlet weak var commentTextView: AutoTextView!
  @IBOutlet weak var avatarImageView: AsyncImageView!
  
  @IBAction func upVoteButtonPressed(sender: AnyObject) {
    SoundPlayer.play("upvote.wav")
    upVoteButton.animation = "pop"
    upVoteButton.force = 3
    upVoteButton.animate()
    delegate?.storyTableViewCellDidPressedUpVote(self, sender: sender)
  }
  
  @IBAction func commentButtonPressed(sender: AnyObject) {
    commentbutton.animation = "pop"
    commentbutton.force = 3
    commentbutton.animate()
    delegate?.storyTableViewCellDidPressedComment(self, sender: sender)
  }
  
  //MARK:
  //MARK: Private Methods
  func configureWithStory(story: JSON) {
    let title = story["title"].string ?? ""
    let badge = story["badge"].string ?? ""
    let userDisplayName = story["user_display_name"].string ?? ""
    let userJob = story["user_job"].string ?? ""
    let createdAt = story["created_at"].string ?? ""
    let voteCount = story["vote_count"].int!
    let commentCount = story["comment_count"].int!
    //let comment = story["comment"].string ?? ""
    let commentHTML = story["comment_html"].string ?? ""
    
    if let commentTextView = commentTextView {
     // commentTextView.text = comment
      commentTextView.attributedText = htmlToAttributedString(commentHTML + "<style>*{font-family:\"Avenir Next\";font-size:16px;line-height:20px}img{max-width:300px}</style>")
    }
    
    let userPortraitUrl = story["user_portrait_url"].string
    avatarImageView.url = userPortraitUrl?.toURL()
    
    avatarImageView.placeholderImage = UIImage(named: "content-avatar-default")
    titleLabel.text = title
    badgeImageView.image = UIImage(named: "badge-" + badge)
    authorLabel.text = userDisplayName + "," + userJob
    timeLabel.text = timeAgoSinceDate(dateFromString(createdAt, format: "yyyy-MM-dd'T'HH:mm:ssZ"), numericDates: true)
    
    let storyId = story["id"].int!
    if LocalStore.isStoryUpvoted(storyId) {
      upVoteButton.setImage(UIImage(named: "icon-upvote-active"), forState: UIControlState.Normal)
      upVoteButton.setTitle(String(voteCount + 1), forState: UIControlState.Normal)
    } else {
      upVoteButton.setImage(UIImage(named: "icon-upvote"), forState: UIControlState.Normal)
      upVoteButton.setTitle(String(voteCount), forState: UIControlState.Normal)
    }

    commentbutton.setTitle(String(commentCount), forState: UIControlState.Normal)
  }
}
