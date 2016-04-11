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
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var upVoteButton: SpringButton!
    @IBOutlet weak var commentbutton: SpringButton!
    
    
    @IBAction func upVoteButtonPressed(sender: AnyObject) {
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
}
