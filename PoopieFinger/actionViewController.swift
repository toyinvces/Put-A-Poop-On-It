//
//  actionViewController.swift
//  PoopieFinger
//
//  Created by Cesar Ramirez on 4/7/16.
//  Copyright © 2016 Cesar Ramirez. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class actionViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    var playSound:AVAudioPlayer = AVAudioPlayer()
    
    var binaryCount = 50
    var timer = NSTimer()
    var touchingScreen = false
    var imageView = UIImageView()
    
    var x = CGFloat()
    var y = CGFloat()
    
    @IBOutlet weak var placeToDo: UIImageView!
    @IBOutlet weak var pooButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var peeButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        if photoExists == true{
            print("taking picture")
            addPhoto()
            
            
            
        }else{
            shareButton.hidden = true
            imageForBackGround = UIImage(named: "\(place)Back.png")!
            loadBackground()
            addPlace()
        }

    }
    
    func loadBackground(){
        
        
        let backgroundImage = UIImageView(frame: UIScreen.mainScreen().bounds)
        backgroundImage.image = imageForBackGround
        backgroundImage.contentMode = .ScaleAspectFill
        backgroundImage.alpha = 1
        self.view.insertSubview(backgroundImage, atIndex: 0)
        
    }
    
    func addPhoto(){
        placeToDo.image = imageFromCamera
    }
    
    func addPlace(){
        placeToDo.image = UIImage(named:"\(place)")
    }
    
    @IBAction func back(sender: AnyObject) {
        photoExists = false
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            
            if pooValue == true{
                let position :CGPoint = touch.locationInView(view)
                
                let pooCount = Int(arc4random_uniform(6) + 1)
                let fartCount = Int(arc4random_uniform(3)+1)
                
                play("fart\(fartCount)")
                
                let imageName = "poo\(pooCount).png"
                let image = UIImage(named: imageName)
                let imageView = UIImageView(image: image!)
                
                imageView.frame = CGRect(x: (position.x-35), y: (position.y-35), width: 70, height: 70)
                view.addSubview(imageView)

            }
            
            
            if peeValue == true {
                
                let position :CGPoint = touch.locationInView(view)
                touchingScreen = true
                
                
                timer = NSTimer(timeInterval: 0.01, target: self, selector: Selector("countUp"), userInfo: nil, repeats: true)
                NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
                
                let pooN = Int(arc4random_uniform(3) + 1)
                
               // playPee(1)
                
                play("pee")
                
                let imageName = "pee.png"
                let image = UIImage(named: imageName)
                imageView = UIImageView(image: image!)
                
                
                x = position.x
                y = position.y
                
                imageView.frame = CGRect(x: x, y: y, width: 50, height: 50)
                
                self.view.addSubview(imageView)
                
            }
    
            
        }
        
    }


    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        super.touchesEnded(touches, withEvent: event)
        touchingScreen = false
        binaryCount = 50
        timer.invalidate()
    }
    
    func countUp(){
        binaryCount++
        imageView.frame = CGRect(x: (x - CGFloat(binaryCount/2)), y: (y-CGFloat(binaryCount/2)), width: CGFloat(binaryCount), height: CGFloat(binaryCount))
    }
    
    @IBAction func pee(sender: AnyObject) {
        
        peeValue = true
        pooValue = false
        
    }
    
    @IBAction func poo(sender: AnyObject) {
        peeValue = false
        pooValue = true
        
    }
    
    @IBAction func share(sender: AnyObject) {
        hideStuff()
        
                UIGraphicsBeginImageContext(view.frame.size)
                view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
                let image = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
        

        //var messageStr:String  = "Check out my awesome iPicSafe photo!"
        var img: UIImage = image
        //var shareItems:Array = [img, messageStr]
        var shareItems:Array = [img]
        let activityViewController:UIActivityViewController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        activityViewController.excludedActivityTypes = [UIActivityTypePrint, UIActivityTypePostToWeibo, UIActivityTypeCopyToPasteboard, UIActivityTypeAddToReadingList, UIActivityTypePostToVimeo]
        self.presentViewController(activityViewController, animated: true, completion: nil)
        
        unhideStuff()
        
    }
    
    func hideStuff(){
        pooButton.hidden = true
        peeButton.hidden = true
        shareButton.hidden = true
        backButton.hidden = true
        
    }
    
    func unhideStuff(){
        pooButton.hidden = false
        peeButton.hidden = false
        shareButton.hidden = false
        backButton.hidden = false
        
    }
    
    func play(sound: String){
        
        let playSoundURL:NSURL = NSBundle.mainBundle().URLForResource("\(sound)", withExtension: "mp3")!
        
        do { playSound = try AVAudioPlayer(contentsOfURL: playSoundURL, fileTypeHint: nil) }
        catch { return }
        //bgMusic.numberOfLoops = 1
        playSound.prepareToPlay()
        playSound.play()
        
        
        
    }
    
    
    

    
    
    
    
    
}












