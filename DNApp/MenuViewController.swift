//
//  MenuViewController.swift
//  DNApp
//
//  Created by Shadez Prado on 03/04/2016.
//  Copyright © 2016 Kryptonite. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet var dialogView: DesignableView!
    
    //MARK:
    //MARK: IBAction
    @IBAction func closeButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        dialogView.animation = "fall"
        dialogView.animate()
    }

}
