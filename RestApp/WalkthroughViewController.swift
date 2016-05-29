//
//  WalkthroughViewController.swift
//  RestApp
//
//  Created by Macrinici Dan on 5/29/16.
//  Copyright © 2016 Daniel Macrinici. All rights reserved.
//

import UIKit

class WalkthroughViewController: UIViewController {

    
    // These IBOutlets are already connect for you. We'll configure these outlets later
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    
    
    
    
    // MARK: - Data model for each walkthrough screen
    var index = 0               // the current page index
    var headerText = ""
    var imageName = ""
    var descriptionText = ""
    
    // Just to make sure that the status bar is white - it depends on your preference
    override func preferredStatusBarStyle() -> UIStatusBarStyle
    {
        return .LightContent
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        headerLabel.text = headerText
        descriptionLabel.text = descriptionText
        imageView.image = UIImage(named: imageName)
        
        pageControl.currentPage = self.index
        
        
        // customize the next and start button
        startButton.hidden = (index == 3) ? false : true
        nextButton.hidden = (index == 3) ? true : false
        startButton.layer.cornerRadius = 5.0
        startButton.layer.masksToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func startClicked(sender: AnyObject) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setBool(true, forKey: "DisplayedWalkthrough")
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func nextClicked(sender: AnyObject) {
        let pageViewController = self.parentViewController as! PageViewController
        pageViewController.nextPageWithIndex(index)
    }
    

}
