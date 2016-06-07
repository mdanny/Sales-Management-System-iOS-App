//
//  SignupViewController.swift
//  RestApp
//
//  Created by Macrinici Dan on 6/7/16.
//  Copyright © 2016 Daniel Macrinici. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        displayWalkthroughs()
    }
    
    func displayWalkthroughs() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let displayedWalkthrough = userDefaults.boolForKey("DisplayedWalkthrough")
        
        if !displayedWalkthrough {
            if let pageViewController = storyboard?.instantiateViewControllerWithIdentifier("PageViewController") {
                self.presentViewController(pageViewController, animated: true, completion: nil)
            }
        }
        
    }
}
