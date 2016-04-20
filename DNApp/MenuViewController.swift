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
}

class MenuViewController: UIViewController {

  weak var delegate: MenuViewControllerDelegate?
  
    @IBOutlet var dialogView: DesignableView!
    
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
  }

}
