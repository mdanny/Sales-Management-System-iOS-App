//
//  RegistrationViewController1.swift
//  RestApp
//
//  Created by Macrinici Dan on 5/19/16.
//  Copyright © 2016 Daniel Macrinici. All rights reserved.
//

import UIKit

class RegistrationViewController1: UIViewController {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    
    var name: String?
    var surname: String?
    var gender: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print("NAME: \(nameLabel.text), SURNAME: \(surnameLabel.text), GENDER: \(genderLabel.text)")
    }
    
    override func viewDidAppear(animated: Bool) {
        nameLabel.text = self.name!
        surnameLabel.text = self.surname!
        genderLabel.text = self.gender!
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

}
