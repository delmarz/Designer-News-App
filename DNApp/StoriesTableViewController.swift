//
//  StoriesTableViewController.swift
//  DNApp
//
//  Created by Shadez Prado on 03/04/2016.
//  Copyright © 2016 Kryptonite. All rights reserved.
//

import UIKit


class StoriesTableViewController: UITableViewController, StoryTableViewCellDelegate{
  
  let transitionManager = TransitionManager()
  var stories: JSON! = []
  var isFirstTime = true
  
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
    tableView.estimatedRowHeight = 100
    tableView.rowHeight = UITableViewAutomaticDimension
    
    loadStories("", page: 1)
    
    print(loadStories("", page: 1))
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(true)
    if isFirstTime {
      view.showLoading()
      isFirstTime = false
    }
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
    print("up vote")
  }
  
  func storyTableViewCellDidPressedComment(cell: StoryTableViewCell, sender: AnyObject) {
    print("comment")
    performSegueWithIdentifier("CommentSegue", sender: cell)
  }
  
  //MARK:
  //MARK: Private Methods
  
  func loadStories(section: String, page: Int) {
    DNService.storiesForSection(section, page: page) { (JSON) ->() in
            self.stories = JSON["stories"]
            print(JSON)
            self.tableView.reloadData()
            self.view.hideLoading()
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
      let url = stories[indexPath.row]["url"].string!//data[indexPath.row]["url"].string!
      toView.transitioningDelegate = transitionManager
      toView.url = url
    }
    
  }
  
  
}
