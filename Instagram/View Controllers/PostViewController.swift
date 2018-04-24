//
//  PostViewController.swift
//  Instagram
//
//  Created by user132893 on 4/15/18.
//  Copyright © 2018 user132893. All rights reserved.
//

import UIKit

class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var caption: UITextField!
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func cancel(_ sender: Any) {
        self.performSegue(withIdentifier: "cancel", sender: nil)
    }
    
    
    @IBAction func pickImage(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            vc.sourceType = .camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            vc.sourceType = .photoLibrary
        }
        
        self.present(vc, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        // Do something with the images (based on your use case)
        if (originalImage.size.width > 1000 && originalImage.size.height > 1000) || (editedImage.size.width > 1000 && editedImage.size.height > 1000){
            self.image = resize(image: editedImage, newSize: CGSize(width:900,height:900))
        }
        else
        {
            self.image = editedImage
        }
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRect(x: 0,y: 0,width: newSize.width,height: newSize.height))
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    @IBAction func share(_ sender: Any) {
        let caption_text = caption.text ?? ""
        
        if(self.image != nil)
        {
            Post.postUserImage(image: self.image, withCaption: caption_text, withCompletion: { (success, error) in
                
                if let error = error{
                    print(error.localizedDescription)
                }
                else
                {
                    print("Post shared!")
                    self.performSegue(withIdentifier: "postCreated", sender: nil)
                }
                
                
            })
        }
        else
        {
            
        }
        
    }
    
}
