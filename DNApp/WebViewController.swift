//
//  WebViewController.swift
//  DNApp
//
//  Created by Shadez Prado on 03/04/2016.
//  Copyright © 2016 Kryptonite. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {

  @IBOutlet weak var progressView: UIProgressView!
  @IBOutlet weak var webView: UIWebView!
  var hasFinishedLoading = false
  var story: JSON!
  //MARK:
  //MARK: View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
      let url = story["url"].string ?? ""
      let targetURL = NSURL(string: url)
      let request = NSURLRequest(URL: targetURL!)
      webView.loadRequest(request)
      webView.delegate = self
    print(url)
    UIApplication.sharedApplication().statusBarHidden = true
  }
  
  //MARK:
  //MARK: IBACtion
  @IBAction func closeButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        UIApplication.sharedApplication().statusBarHidden = false
    }
  
  @IBAction func shareButtonPressed(sender: AnyObject) {
    let title = story["title"].string ?? ""
    let url = story["url"].string ?? ""
    let actionViewController = UIActivityViewController(activityItems: [title, url], applicationActivities: nil)
    actionViewController.setValue(title, forKey: "subject")
    actionViewController.excludedActivityTypes = [UIActivityTypeAirDrop]
    presentViewController(actionViewController, animated: true, completion: nil)
  }
  
  
  //MARK:
  //MARK: WebView Delegate
  func webViewDidStartLoad(webView: UIWebView) {
    hasFinishedLoading = false
    updateProgress()
  }
  
  func webViewDidFinishLoad(webView: UIWebView) {
    delay(1) { [weak self] in
      if let _self = self {
        _self.hasFinishedLoading = true
      }
    }
  }
  
  deinit {
    webView.stopLoading()
    webView.delegate = nil
  }
  
  func updateProgress() {
    if progressView.progress >= 1 {
      progressView.hidden = true
    } else {
      if hasFinishedLoading {
        progressView.progress += 0.002
      } else {
        if progressView.progress <= 0.3 {
          progressView.progress += 0.004
        } else if progressView.progress <= 0.6 {
          progressView.progress += 0.002
        } else if progressView.progress <= 0.9 {
          progressView.progress += 0.001
        } else if progressView.progress <= 0.94 {
          progressView.progress += 0.0001
        } else {
          progressView.progress = 0.9401
        }
      }
      
      delay(0.008) { [weak self] in
        if let _self = self {
          _self.updateProgress()
        }
      }
      
    }
  }
  

  
  
}
