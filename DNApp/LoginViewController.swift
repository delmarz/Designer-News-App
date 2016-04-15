//
//  LoginViewController.swift
//  DNApp
//
//  Created by Kryptonite on 3/31/16.
//  Copyright © 2016 Kryptonite. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

  @IBOutlet weak var dialogView: DesignableView!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  
  //MARK:
  //MARK: IBAction
  @IBAction func loginButtonPressed(sender: AnyObject) {
    dialogView.animation = "shake"
    dialogView.animate()
  }

    @IBAction func closeButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
  
  //MARK:
  //MARK: Private Methods
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    view.endEditing(true)
  }

}
