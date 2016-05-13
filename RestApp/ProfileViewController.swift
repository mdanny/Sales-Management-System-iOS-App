//
//  Profile.swift
//  RestApp
//
//  Created by Macrinici Dan on 5/11/16.
//  Copyright © 2016 Daniel Macrinici. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ProfileViewController: UIViewController {
 
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var barButtonItem: UIBarButtonItem!
    @IBOutlet weak var collectionView: UIView!
    
    var user: AnyObject?
    var productNames: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameLabel.text = self.user!["profile"]!!["name"] as? String
        self.emailLabel.text = self.user!["email"]! as? String
        self.fetchGravatar()
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let tuple = user!["history"]!! as! NSArray
        
//        for idx in 0..<tuple.count {
//            var elem = tuple[idx]["item"]!!["name"] as! String
//            productNames.append(elem)
//        }
        
//        print("This is the TUPLE CONVERTED TO DICTIONARY!!!!", productNames)
        userDefaults.setObject(tuple, forKey: "userProfile")
    }
    
    func scaleUIImageToSize(let image: UIImage, let size: CGSize) -> UIImage {
        let hasAlpha = false
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        image.drawInRect(CGRect(origin: CGPointZero, size: size))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
    
    func fetchGravatar() {
        let imageSize = CGSize(width: 200, height: 200)
        if let gravatar = user!["profile"]!!["picture"] as? String {
            Alamofire.request(.GET, gravatar).responseImage {
                response in
                if let image = response.result.value {
                    print("This is the gravatar \(image)")
                    let scaledImage = self.scaleUIImageToSize(image, size: imageSize)
                    self.imgView.frame = CGRectMake(50, 200, scaledImage.size.width, scaledImage.size.height)
                    self.imgView.image = scaledImage
                    print("This is the image size: ",self.imgView.image?.size)
                    self.imgView.layer.cornerRadius = self.imgView.frame.size.height/4
                    self.imgView.layer.borderWidth = 1
                    self.imgView.layer.borderColor = UIColor.blueColor().CGColor
                    self.imgView.clipsToBounds = true
                }
            }
        }
        
    }
    
}