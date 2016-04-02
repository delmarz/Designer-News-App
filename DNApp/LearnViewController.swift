//
//  LearnViewController.swift
//  DNApp
//
//  Created by Kryptonite on 4/1/16.
//  Copyright © 2016 Kryptonite. All rights reserved.
//

import UIKit

class LearnViewController: UIViewController {

  
  @IBOutlet weak var dialogView: DesignableView!
  @IBOutlet weak var bookImageView: DesignableImageView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }

  override func viewWillAppear(animated: Bool) {
    dialogView.animate()
  }
  
  //MARK: 
  //MARK: IBAction
  
  @IBAction func learnButtonPressed(sender: AnyObject) {
    bookImageView.animation = "pop"
    bookImageView.animate()
  }
  
}
