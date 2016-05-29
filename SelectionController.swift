//
//  SelectionController.swift
//  PoopieFinger
//
//  Created by Cesar Ramirez on 4/7/16.
//  Copyright © 2016 Cesar Ramirez. All rights reserved.
//

import Foundation
import UIKit


var peeValue: Bool = Bool()
var pooValue: Bool = Bool()
var place: String = String()
var imageFromCamera: UIImage = UIImage()
var imageForBackGround: UIImage = UIImage()
var photoExists: Bool = Bool()
var useCamera: Bool = Bool()


class SelectionController: UIViewController,  UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    var places = ["Bathroom", "Side Walk", "Tokyo", "New York", "Grass", "Potty Pad"]
    
    @IBOutlet weak var camera: UIButton!
    
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    
    
    override func viewDidLoad() {
        
        camera.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: UIScreen.mainScreen().bounds)
        backgroundImage.image = UIImage(named: "fingersBackground.png")
        backgroundImage.contentMode = .ScaleAspectFill
        backgroundImage.alpha = 0.2
        self.view.insertSubview(backgroundImage, atIndex: 0)
        
        photoExists = false
        peeValue = false
        pooValue = true
        useCamera = false
        
}
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return places.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SelectionControllerViewCell", forIndexPath: indexPath) as! SelectionControllerViewCell
        cell.place.text = "\(places[indexPath.row])"
        cell.image.image = UIImage(named: "\(places[indexPath.row])Icon.png")
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath:NSIndexPath)
    {
        place = places[indexPath.row]
        action()
    }

    @IBAction func pickCamera(sender: AnyObject) {
        
       takePicture()
    
    
    }
    
   
    @IBAction func pickAlbum(sender: AnyObject) {
        getPictureFromAlbum()
    }
    
    
    func getPictureFromAlbum(){
    
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
        imagePicker.editing = true
        presentViewController(imagePicker, animated: true, completion: nil)
    }

    func takePicture(){
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        imagePicker.editing = true
        presentViewController(imagePicker, animated: true, completion: nil)
        
        
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        
        if let FromCamera = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.dismissViewControllerAnimated(true, completion: nil)
            
            
            imageFromCamera = FromCamera
            photoExists = true
            
            action()
            
            
        }
        
        
    }
    
    func action(){
        let actionController =  self.storyboard?.instantiateViewControllerWithIdentifier("actionViewController") as! actionViewController
        self.presentViewController(actionController, animated: true, completion: nil)
        
    }

}



    
    
