//
//  CommentsTableViewController.swift
//  DNApp
//
//  Created by Kryptonite on 4/12/16.
//  Copyright © 2016 Kryptonite. All rights reserved.
//

import UIKit

class CommentsTableViewController: UITableViewController, CommentTableViewCellDelegate, StoryTableViewCellDelegate, ReplyViewControllerDelegate{
    
    var story: JSON!
    var comments: [JSON]!
    var transitionManager = TransitionManager()
    
    @IBOutlet weak var indentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        comments = flattenComments(story["comments"].array ?? []) //story["comments"]
        print(comments.count)
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        refreshControl?.addTarget(self, action: #selector(CommentsTableViewController.reloadStory), forControlEvents: UIControlEvents.ValueChanged)
        
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSFontAttributeName], forState: <#T##UIControlState#>)
    }
    //MARK:
    //MARK: ReloadControl
    func reloadStory() {
        view.showLoading()
        let storyId = story["id"].int!
        DNService.storyForId(storyId) { (JSON) in
            self.view.hideLoading()
            self.story = JSON["story"]
            self.comments = self.flattenComments(JSON["story"]["comments"].array ?? []) //JSON["story"]["comments"]
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
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
        if LocalStore.getToken() == nil {
            performSegueWithIdentifier("LoginSegue", sender: self)
        } else {
            performSegueWithIdentifier("ReplySegue", sender: cell)
        }
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
        if LocalStore.getToken() == nil {
            performSegueWithIdentifier("LoginSegue", sender: self)
        } else {
            performSegueWithIdentifier("ReplySegue", sender: cell)
        }
    }
    
    //MARK:
    //MARK: ReplyViewController Delegate
    func replyViewControllerDidPressedSend(controller: ReplyViewController) {
        reloadStory()
    }
    
    //MARK:
    //MARK: Helper
    func flattenComments(comments: [JSON]) -> [JSON] {
        let flattenedComments = comments.map(commentsForComment).reduce([], combine: +)
        return flattenedComments
    }
    
    func commentsForComment(comment: JSON) -> [JSON] {
        let comments = comment["comments"].array ?? []
        return comments.reduce([comment]) { acc, x in  acc + self.commentsForComment(x)
        }
    }
    //MARK:
    //MARK: Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ReplySegue" {
            let toView = segue.destinationViewController as! ReplyViewController
            if let cell = sender as? CommentTableViewCell {
                let indexPath = tableView.indexPathForCell(cell)!
                let comment = comments[indexPath.row-1]
                toView.comment = comment
            }
            
            if let _ = sender as? StoryTableViewCell {
                toView.story = story
                
            }
            toView.transitioningDelegate = transitionManager
            toView.delegate = self
        }
    }
    
}
