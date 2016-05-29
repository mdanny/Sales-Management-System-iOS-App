//
//  RegistrationViewController.swift
//  RestApp
//
//  Created by Macrinici Dan on 5/19/16.
//  Copyright © 2016 Daniel Macrinici. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc0 = RegistrationViewController0(nibName: "RegistrationViewController0", bundle: nil)
        self.addChildViewController(vc0)
        self.scrollView.addSubview(vc0.view)
        vc0.didMoveToParentViewController(self)
        
        let vc1 = RegistrationViewController1(nibName: "RegistrationViewController1", bundle: nil)
        var frame1 = vc1.view.frame
        frame1.origin.x = self.view.frame.size.width
        vc1.view.frame = frame1
        self.addChildViewController(vc1)
        self.scrollView.addSubview(vc1.view)
        vc1.name = vc0.name
        vc1.surname = vc0.surname
        vc1.gender = vc0.gender
        vc1.didMoveToParentViewController(self)
        
        let vc2 = RegistrationViewController2(nibName: "RegistrationViewController2", bundle: nil)
        var frame2 = vc2.view.frame
        frame2.origin.x = self.view.frame.size.width * 2
        vc2.view.frame = frame2
        self.addChildViewController(vc2)
        self.scrollView.addSubview(vc2.view)
        vc2.didMoveToParentViewController(self)
        
        let vc3 = RegistrationViewController3(nibName: "RegistrationViewController3", bundle: nil)
        var frame3 = vc3.view.frame
        frame3.origin.x = self.view.frame.size.width * 3
        vc3.view.frame = frame3
        self.addChildViewController(vc3)
        self.scrollView.addSubview(vc3.view)
        vc3.didMoveToParentViewController(self)
        
        self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 4, self.view.frame.size.height - 66)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
