//
//  TaskViewController.swift
//  ToDo!
//
//  Created by Alec Tenefrancia on 4/21/20.
//  Copyright © 2020 Alec Tenefrancia. All rights reserved.
//

import UIKit
import AlamofireImage

class TaskViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //Properties
    
    
    
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Handle the text field’s user input through delegate callbacks.
        nameTextField.delegate = self
    }
    
    //UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }// end func textFieldShouldReturn
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //pressing done on keyboard updates Title
        
    }//end func textFieldDidEndEditing
    
    //UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }// end func imagePickerControllerDidCancel
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       
    // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[.originalImage] as? UIImage else {
           fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
       }
        
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
       
    
   }// end func imagePickerController
    
    
    
    
    //Actions
    
    @IBAction func setDefaultLabelText(_ sender: UIButton) {
        //changes TaskNameLabel to Default Text
        
    }// end func setDefaultLabelText
    

    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        // Hide the keyboard.
           nameTextField.resignFirstResponder()
           
           // UIImagePickerController is a view controller that lets a user pick media from their photo library.
           let imagePickerController = UIImagePickerController()
           
           // Only allow photos to be picked, not taken.
           imagePickerController.sourceType = .photoLibrary
           
           // Make sure ViewController is notified when the user picks an image.
           imagePickerController.delegate = self
           present(imagePickerController, animated: true, completion: nil)
        
        
    }//end func selectImageFromPhotoLibrary
}

