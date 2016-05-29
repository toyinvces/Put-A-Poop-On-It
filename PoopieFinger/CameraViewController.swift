//
//  CameraViewController.swift
//  PoopieFinger
//
//  Created by Cesar Ramirez on 4/8/16.
//  Copyright © 2016 Cesar Ramirez. All rights reserved.
//

import Foundation
import UIKit


class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    

//    var imagePicker: UIImagePickerController!
//    var picker:UIImagePickerController?=UIImagePickerController()
//    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var cameraTake: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    
    var photo: UIImage!
    
    @IBAction func camera(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(imagePicker, animated: true, completion: nil)
        

    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        print("Got an image")
        
        //  imagePickerView.contentMode = UIViewContentMode.ScaleAspectFill
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            
            imageView.image = image
            
            photo = image
            
            //    CameraViewController().imageView.image = image
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let position :CGPoint = touch.locationInView(view)
            
            
            let pooN = Int(arc4random_uniform(3) + 1)
            let soundN = Int(arc4random_uniform(4) + 1)
            
            print(soundN)
          //  playFart(pooN, speed: Float(soundN/2))
            let imageName = "poo1.png"
            let image = UIImage(named: imageName)
            let imageView = UIImageView(image: image!)
            
            imageView.frame = CGRect(x: (position.x-75), y: (position.y-75), width: 150, height: 150)
            view.addSubview(imageView)
            
            
            
        }
    }
    
    
    
    
    
    @IBAction func sharePhoto(sender: AnyObject) {
        
       // hideStuff()
        
        shareImage()
        
      //  unhideStuff()
        
        
    }
    
    
    func shareImage() {
        
//        UIGraphicsBeginImageContext(view.frame.size)
//        view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
// 
//      //  let img: UIImage = image
//
//        //var shareItems:Array = [img, messageStr]
//        let img: UIImage = image!
//        
        
        let textToShare = "Swift is awesome!  Check out this website about it!"
        
        if let myWebsite = NSURL(string: "http://www.codingexplorer.com/") {
            let objectsToShare = [textToShare, myWebsite]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            self.presentViewController(activityVC, animated: true, completion: nil)
        }

        
//        let shareItems:Array = ["www.google.com"]
//        let activityViewController:UIActivityViewController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
//        activityViewController.excludedActivityTypes = [UIActivityTypePrint, UIActivityTypePostToWeibo, UIActivityTypeCopyToPasteboard, UIActivityTypeAddToReadingList, UIActivityTypePostToVimeo]
//        self.presentViewController(activityViewController, animated: true, completion: nil)
   
    
    }
    
    
    func hideStuff(){
        cameraTake.hidden = true
        shareButton.hidden = true
        
    }
    
    func unhideStuff(){
        cameraTake.hidden = false
        shareButton.hidden = false
    }
    
    
}