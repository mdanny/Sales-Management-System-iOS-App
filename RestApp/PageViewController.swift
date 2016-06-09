//
//  PageViewController.swift
//  RestApp
//
//  Created by Macrinici Dan on 5/29/16.
//  Copyright © 2016 Daniel Macrinici. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {

    
    // Some hard-coded data for our walkthrough screens
    var pageHeaders = ["Learn to shop in a new way!", "Scan Products off the shelf", "Pay with your credit card", "Make your account"]
    var pageImages = ["app1", "app2", "app3", "app4"]
    var pageDescriptions = ["Enhance your shopping experience!", "Be more responsible! Manage your expenses in a smarter way!", "Don't spend time in queues while checkouting!", "Be smarter and more efficient!"]
    
    // make the status bar white (light content)
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // this class is the page view controller's data source itself
        self.dataSource = self
        
        // create the first walkthrough vc
        if let startWalkthroughVC = self.viewControllerAtIndex(0) {
            setViewControllers([startWalkthroughVC], direction: .Forward, animated: true, completion: nil)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    func nextPageWithIndex(index: Int)
    {
        if let nextWalkthroughVC = self.viewControllerAtIndex(index + 1) {
            setViewControllers([nextWalkthroughVC], direction: .Forward, animated: true, completion: nil)
        }
    }
    
    func viewControllerAtIndex(index: Int) -> WalkthroughViewController?
    {
        if index == NSNotFound || index < 0 || index >= self.pageDescriptions.count {
            return nil
        }
        
        if let walkthroughViewController = storyboard?.instantiateViewControllerWithIdentifier("WalkthroughViewController") as? WalkthroughViewController {
            walkthroughViewController.imageName = pageImages[index]
            walkthroughViewController.headerText = pageHeaders[index]
            walkthroughViewController.descriptionText = pageDescriptions[index]
            walkthroughViewController.index = index
            
            return walkthroughViewController
        }
        
        return nil
    }

}

// MARK: - UIPageViewControllerDataSource

extension PageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkthroughViewController).index
        index -= 1
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkthroughViewController).index
        index += 1
        return self.viewControllerAtIndex(index)
    }
}
