//
//  ReplyViewController.swift
//  DNApp
//
//  Created by Kryptonite on 4/25/16.
//  Copyright © 2016 Kryptonite. All rights reserved.
//

import UIKit

protocol ReplyViewControllerDelegate: class {
  func replyViewControllerDidPressedSend(controller: ReplyViewController)
}

class ReplyViewController: UIViewController {
  
  var story: JSON = []
  var comment: JSON = []
  weak var delegate: ReplyViewControllerDelegate?
  @IBOutlet weak var replyTextView: UITextView!
  
  //MARK:
  //MARK: View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    replyTextView.becomeFirstResponder()
  }
  
  //MARK:
  //MARK: IBAction
  @IBAction func sendBarButtonItemPressed(sender: AnyObject) {
    view.showLoading()
    let token = LocalStore.getToken()!
    let body = replyTextView.text
    
    if let storyId = story["id"].int {
      DNService.replyStoryWithId(storyId, token: token, body: body, response: { (successful) in
        self.view.hideLoading()
        if successful {
          self.delegate?.replyViewControllerDidPressedSend(self)
          self.dismissViewControllerAnimated(true, completion: nil)
        } else {
          self.showAlert()
        }
      })
    }
    
    if let commentId  = comment["id"].int {
      DNService.replyCommentWithId(commentId, token: token, body: body, response: { (successful) in
        self.view.hideLoading()
        if successful {
          self.delegate?.replyViewControllerDidPressedSend(self)
          self.dismissViewControllerAnimated(true, completion: nil)
        } else {
          self.showAlert()
        }
      })
    }
    print("the token is: \(token) \n and storyId is: \(story["id"].int)")
  }
  
  //MARK:
  //MARK: Private Methods
  func showAlert() {
    let alert = UIAlertController(title: "Ohhh snap!!...", message: "Something went wrong. Your message wasn't sent. Try again and save your text just in case.", preferredStyle: UIAlertControllerStyle.Alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
    self.presentViewController(alert, animated: false, completion: nil)
  }
  
  
}
