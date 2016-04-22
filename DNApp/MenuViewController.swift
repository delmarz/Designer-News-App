//
//  MenuViewController.swift
//  DNApp
//
//  Created by Shadez Prado on 03/04/2016.
//  Copyright © 2016 Kryptonite. All rights reserved.
//

import UIKit

protocol MenuViewControllerDelegate: class {
  func menuViewControllerDiDPressedTop(controller: MenuViewController)
  func menuViewControllerDidPressedRecent(controller: MenuViewController)
  func menuViewControllerDidPressedLogout(controller: MenuViewController)
}

class MenuViewController: UIViewController, LoginViewControllerDelegate{
  weak var delegate: MenuViewControllerDelegate?
  
  @IBOutlet var dialogView: DesignableView!
  @IBOutlet weak var loginLabel: UILabel!
  
  //MARK:
  //MARK: View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    if LocalStore.getToken() == nil {
      loginLabel.text = "Login"
    } else {
      loginLabel.text = "Logout"
    }
  }
  
  //MARK:
  //MARK: IBAction
  @IBAction func closeButtonPressed(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
    dialogView.animation = "fall"
    dialogView.animate()
  }
  
  @IBAction func topButtonPressed(sender: AnyObject) {
    delegate?.menuViewControllerDiDPressedTop(self)
    closeButtonPressed(sender)
  }
  
  @IBAction func recentButtonPressed(sender: AnyObject) {
    delegate?.menuViewControllerDidPressedRecent(self)
    closeButtonPressed(sender)
  }
  
  @IBAction func loginButtonPressed(sender: AnyObject) {
    if LocalStore.getToken() == nil {
      performSegueWithIdentifier("LoginSegue", sender: self)
    } else {
      LocalStore.deleteToken()
      self.closeButtonPressed(self)
      delegate?.menuViewControllerDidPressedLogout(self)
      print("logout token is", LocalStore.getToken())
    }
  }
  
  //MARK:
  //MARK: LoginViewController Delegate
  func loginWithControllerDidPressed(controller: LoginViewController) {
    closeButtonPressed(self)
    delegate?.menuViewControllerDidPressedLogout(self)
    print("loginpressed delegate")
  }
  
  //MARK:
  //MARK: Segue
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "LoginSegue" {
      let toView = segue.destinationViewController as! LoginViewController
      toView.delegate = self
    }
  }
  
}
