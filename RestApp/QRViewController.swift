//
//  QRViewController.swift
//  RestApp
//
//  Created by Macrinici Dan on 4/21/16.
//  Copyright © 2016 Daniel Macrinici. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire

//Create extension for parsing JSON string to Object

extension String {
    
    var parseJSONString: AnyObject? {
        
        let data = self.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        
        if let jsonData = data {
            
            // Will return an object or nil if JSON decoding fails
            do {
                
                let message = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers)
                if let jsonResult = message as? NSDictionary {
                    
                    return jsonResult // Will return the JSON array output
                }
                else {
                    
                    return nil
                }
            }
            catch let error as NSError {
                
                print("An error occurred: \(error)")
                return nil
            }
        }
        else {
            // Lossless conversion of the string was not possible
            return nil
        }
    }
}

class QRViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    @IBOutlet weak var lblQRCodeLabel: UILabel!
    @IBOutlet weak var lblQRCodeResult: UILabel!
    @IBOutlet weak var buttonLabel: UIButton!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var payButton: UIButton!
    
    //declare the variables
    var objCaptureSession: AVCaptureSession?
    var objCaptureVideoPreviewLayer: AVCaptureVideoPreviewLayer?
    var vwQRCode: UIView?
    var infoString = ""
    var parsedString: String?
    
    // API variables
    var apiName: String?
    var apiCategory: String?
    var apiBrand: String?
    var apiSupermarket: String?
    var apiDescription: String?
    var apiPrice: Int?
    var apiId: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureVideoCapture()
        self.addVideoPreviewLayer()
        self.initializeQRView()
    }
    
    // In the following func we use AVCaptureDevice class to initialize a device object and provide the video as the media type parameter
    func configureVideoCapture() {
        
        let objCaptureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        var error: NSError?
        
        let objCaptureDeviceInput: AnyObject!
        
        do {
            objCaptureDeviceInput = try AVCaptureDeviceInput(device: objCaptureDevice) as AVCaptureDeviceInput
        }
            
        catch let error1 as NSError {
            error = error1
            objCaptureDeviceInput = nil
        }
        
        if (error != nil) {
            let alertController: UIAlertController = UIAlertController(title: "Device Error", message: "Device not supported for this application", preferredStyle: .Alert)
            
            let cancelAction: UIAlertAction = UIAlertAction(title: "Ok Done", style: .Cancel, handler: {(alertAction) -> Void in alertController.dismissViewControllerAnimated(true, completion: nil)
            })
            
            alertController.addAction(cancelAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
        objCaptureSession = AVCaptureSession()
        objCaptureSession?.addInput(objCaptureDeviceInput as! AVCaptureInput)
        
        let objCaptureMetadataOutput = AVCaptureMetadataOutput()
        objCaptureSession?.addOutput(objCaptureMetadataOutput)
        objCaptureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        objCaptureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
    }
    
    
    func addVideoPreviewLayer() {
        objCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: objCaptureSession)
        objCaptureVideoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        objCaptureVideoPreviewLayer?.frame = view.layer.bounds
        self.view.layer.addSublayer(objCaptureVideoPreviewLayer!)
        objCaptureSession?.startRunning()
        
        // Bring any subview to front view, in reverse order
        self.view.bringSubviewToFront(lblQRCodeResult)
        self.view.bringSubviewToFront(lblQRCodeLabel)
        self.view.bringSubviewToFront(buttonLabel)
        self.view.bringSubviewToFront(postButton)
        self.view.bringSubviewToFront(payButton)
    }
    
    func initializeQRView() {
        vwQRCode = UIView()
        vwQRCode?.layer.borderColor = UIColor.redColor().CGColor
        vwQRCode?.layer.borderWidth = 5
        self.view.addSubview(vwQRCode!)
        self.view.bringSubviewToFront(vwQRCode!)
    }
    
    // Implement AVCaptureMetadataOutputObjectsDelegate
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        if metadataObjects == nil || metadataObjects.count == 0 {
            vwQRCode?.frame = CGRectZero
            lblQRCodeResult.text = "No QRCode text detected"
            return
        }
        
        let objMetadataMachineReadableCodeObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if objMetadataMachineReadableCodeObject.type == AVMetadataObjectTypeQRCode {
            let objBarCode = objCaptureVideoPreviewLayer?.transformedMetadataObjectForMetadataObject(objMetadataMachineReadableCodeObject as AVMetadataMachineReadableCodeObject) as! AVMetadataMachineReadableCodeObject
            vwQRCode?.frame = objBarCode.bounds
            
            if objMetadataMachineReadableCodeObject.stringValue != nil {
                lblQRCodeResult.text = objMetadataMachineReadableCodeObject.stringValue
                self.infoString += lblQRCodeResult.text!
                objCaptureSession?.stopRunning()
            }
        }
    }
    
  
    @IBAction func buttonTapped(sender: UIButton) {
        if !self.infoString.isEmpty {
            let jsonString = self.infoString
            let json: AnyObject? = jsonString.parseJSONString
            let parsedJSON = json! as! NSDictionary
            
            print("---------PARSED JSON FROM QRViewController:---------- \(parsedJSON)")
            // Define the constants for API POST request
            self.apiName = parsedJSON.valueForKey("name") as? String
            self.apiCategory = parsedJSON.valueForKey("category") as? String
            self.apiBrand = parsedJSON.valueForKey("brand") as? String
            self.apiSupermarket = parsedJSON.valueForKey("supermarket") as? String
            self.apiDescription = parsedJSON.valueForKey("description") as? String
            self.apiPrice = parsedJSON.valueForKey("price") as? Int
            self.apiId = parsedJSON.valueForKey("_id") as? String
            
            let alertControllerSuccess = UIAlertController(title: "Cart", message:"Your item is: \(parsedJSON)\n" , preferredStyle: .Alert)
            alertControllerSuccess.addAction(UIAlertAction(title: "Continue", style: .Default, handler: continueScanning))
            presentViewController(alertControllerSuccess, animated: true, completion: nil)
        }
        else {
            Alamofire.request(.GET, "http://46.101.104.55:3000/cart")
            let alertControllerFailure = UIAlertController(title: "Cart", message:"Your item is:  \n You have no items in the cart." , preferredStyle: .Alert)
            alertControllerFailure.addAction(UIAlertAction(title: "Continue", style: .Default, handler: continueScanning))
            presentViewController(alertControllerFailure, animated: true, completion: nil)
        }
    }
    
    func continueScanning(action: UIAlertAction! = nil) {
        // Clear infoString after parsing it
        self.infoString = ""
        objCaptureSession?.startRunning()
    }
    
    @IBAction func postButtonTapped(sender: UIButton) {
        self.performSegueWithIdentifier("ShowAddViewSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "ShowAddViewSegue" {
            let addViewController = segue.destinationViewController as! AddViewController
            
            addViewController.apiName = self.apiName
            addViewController.apiCategory = self.apiCategory
            addViewController.apiBrand = self.apiBrand
            addViewController.apiSupermarket = self.apiSupermarket
            addViewController.apiDescription = self.apiDescription
            addViewController.apiPrice = self.apiPrice
            addViewController.apiId = self.apiId
        }
    }
    
}
