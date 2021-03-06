//
//  LoginViewController.swift
//  DNApp
//
//  Created by Kryptonite on 3/31/16.
//  Copyright © 2016 Kryptonite. All rights reserved.
//

import UIKit

protocol LoginViewControllerDelegate: class {
  func loginWithControllerDidPressed(controller: LoginViewController)
}

class LoginViewController: UIViewController, UITextFieldDelegate {

  @IBOutlet weak var dialogView: DesignableView!
  @IBOutlet weak var emailTextField: DesignableTextField!
  @IBOutlet weak var passwordTextField: DesignableTextField!
  @IBOutlet weak var emailImageView: SpringImageView!
  @IBOutlet weak var passwordImageView: SpringImageView!
  weak var delegate: LoginViewControllerDelegate?
  
    override func viewDidLoad() {
        super.viewDidLoad()
      emailTextField.delegate = self
      passwordTextField.delegate = self
    }
  
  //MARK:
  //MARK: IBAction
  @IBAction func loginButtonPressed(sender: AnyObject) {
    DNService.loginWithEmail(emailTextField.text!, password: passwordTextField.text!) { (token) in
      if let token = token {
        LocalStore.saveToken(token)
        self.dismissViewControllerAnimated(true, completion: nil)
        self.delegate?.loginWithControllerDidPressed(self)
        print("this is token " + token)
      } else {
        self.dialogView.animation = "shake"
        self.dialogView.animate()
      }
    }

  }

    @IBAction func closeButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
  
  //MARK:
  //MARK: Private Methods
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    view.endEditing(true)
  }
  
  //MARK:
  //MARK: TextField Delegate
  func textFieldDidBeginEditing(textField: UITextField) {
    if textField == emailTextField {
      emailImageView.image = UIImage(named: "icon-mail-active")
      emailImageView.animate()
    } else {
      emailImageView.image = UIImage(named: "icon-mail")
    }
    
    if textField == passwordTextField {
      passwordImageView.image = UIImage(named: "icon-password-active")
      passwordImageView.animate()
    } else {
      passwordImageView.image = UIImage(named: "icon-password")
    }
  }
  
  func textFieldDidEndEditing(textField: UITextField) {
     emailImageView.image = UIImage(named: "icon-mail")
     passwordImageView.image = UIImage(named: "icon-password")
  }

}
