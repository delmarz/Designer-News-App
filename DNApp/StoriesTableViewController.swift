//
//  StoriesTableViewController.swift
//  DNApp
//
//  Created by Shadez Prado on 03/04/2016.
//  Copyright © 2016 Kryptonite. All rights reserved.
//

import UIKit

class StoriesTableViewController: UITableViewController, StoryTableViewCellDelegate, MenuViewControllerDelegate, LoginViewControllerDelegate{
  
  @IBOutlet weak var loginBarButtonItem: UIBarButtonItem!
  let transitionManager = TransitionManager()
  var stories: JSON! = []
  var isFirstTime = true
  var section = ""
  
  //MARK:
  //MARK: IBAction
  @IBAction func menuBarButtonItemPressed(sender: AnyObject) {
    performSegueWithIdentifier("MenuSegue", sender: self)
  }
  
  @IBAction func loginBarButtonItemPressed(sender: AnyObject) {
    performSegueWithIdentifier("LoginSegue", sender: self)
  }
  
  //MARK:
  //MARK: View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    refreshControl?.addTarget(self, action: #selector(StoriesTableViewController.refreshStories), forControlEvents: UIControlEvents.ValueChanged)
    
    tableView.estimatedRowHeight = 100
    tableView.rowHeight = UITableViewAutomaticDimension
    loadStories("", page: 1)

    let barButtonItem = UIBarButtonItem(title: "Top Stories", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
    barButtonItem.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Avenir Next", size: 18)!], forState: UIControlState.Normal)
    navigationItem.backBarButtonItem = barButtonItem
    
    loginBarButtonItem.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Avenir Next", size: 18)!], forState: UIControlState.Normal)
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(true)
    if isFirstTime {
      view.showLoading()
      isFirstTime = false
    }
  }
  
  //MARK:
  //MARK: Refresh Stories
  func refreshStories() {
    SoundPlayer.play("refresh.wav")
    loadStories(section, page: 1)
  }
  
  //MARK:
  //MARK: TableViewDataSource
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return stories.count//data.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("StoryCell") as! StoryTableViewCell
    let story = stories[indexPath.row]//data[indexPath.row]
    cell.configureWithStory(story)
    cell.delegate = self
    return cell
  }
  
  //MARK:
  //MARK: TableViewDelegate
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    performSegueWithIdentifier("WebSegue", sender: indexPath)
  }
  
  //MARK:
  //MARK: StoryTableViewCellDelegate
  func storyTableViewCellDidPressedUpVote(cell: StoryTableViewCell, sender: AnyObject) {
    if let token = LocalStore.getToken() {
      let indexPath = tableView.indexPathForCell(cell)!
      let story = stories[indexPath.row]
      let storyId = story["id"].int!
      LocalStore.saveUpvotedStory(storyId)
      cell.configureWithStory(story)

      DNService.upvoteStoryWithId(storyId, token: token
        , response: { (successful) in
          // do something
          print("success upvote!")

//        cell.upVoteButton.setImage(UIImage(named: "icon-upvote-active"), forState: UIControlState.Normal)
//        cell.upVoteButton.setTitle(String(story["vote_count"]), forState: UIControlState.Normal)
          print("story id \(storyId)")
      })
    } else {
      performSegueWithIdentifier("LoginSegue", sender: self)
    }
    print("up vote")

  }
  
  func storyTableViewCellDidPressedComment(cell: StoryTableViewCell, sender: AnyObject) {
    print("comment")
    performSegueWithIdentifier("CommentSegue", sender: cell)
  }
  
  //MARK:
  //MARK: MenuViewController Delegate
  func menuViewControllerDiDPressedTop(controller: MenuViewController) {
    view.showLoading()
    loadStories("", page: 1)
    navigationItem.title = "Top Stories"
    section = ""
  }
  
  func menuViewControllerDidPressedRecent(controller: MenuViewController) {
    view.showLoading()
    loadStories("recent", page: 1)
    navigationItem.title = "Recent Stories"
    section = "recent"
  }
  
  func menuViewControllerDidPressedLogout(controller: MenuViewController) {
    view.showLoading()
    loadStories(section, page: 1)
    print("test logout")
  }
  
  
  //MARK:
  //MARK: LoginViewController Delegate
  func loginWithControllerDidPressed(controller: LoginViewController) {
    loadStories(section, page: 1)
    view.showLoading()
    print("login test test")
  }
  
  //MARK:
  //MARK: Private Methods
  func loadStories(section: String, page: Int) {
    DNService.storiesForSection(section, page: page) { (JSON) ->() in
      self.stories = JSON["stories"]
      //print(JSON)
      
      if LocalStore.getToken() == nil {
        self.loginBarButtonItem.title = "Login"
        self.loginBarButtonItem.enabled = true
      } else {
        self.loginBarButtonItem.title = ""
        self.loginBarButtonItem.enabled = false
      }
      self.tableView.reloadData()
      self.view.hideLoading()
      self.refreshControl?.endRefreshing()
    }
  }
  
  //MARK:
  //MARK: Segue
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "CommentSegue" {
      let toView = segue.destinationViewController as! CommentsTableViewController
      let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
      let story = stories[indexPath!.row]//data[indexPath!.row]
      toView.story = story
    }
    
    if segue.identifier == "WebSegue" {
      let toView = segue.destinationViewController as! WebViewController
      let indexPath = sender as! NSIndexPath
      let story = stories[indexPath.row]//["url"].string!  //data[indexPath.row]["url"].string!
      toView.transitioningDelegate = transitionManager
      toView.story = story
    }
    
    if segue.identifier == "MenuSegue" {
      let toView = segue.destinationViewController as! MenuViewController
      toView.delegate = self
    }
    
    if segue.identifier == "LoginSegue" {
      let toView = segue.destinationViewController as! LoginViewController
      toView.delegate = self
    }
    
  }
  
  
  
  
  
  
  
}
