//
//  TaskViewController.swift
//  ToDo!
//
//  Created by Alec Tenefrancia on 4/21/20.
//  Copyright © 2020 Alec Tenefrancia. All rights reserved.
//

import UIKit
import os.log
import AlamofireImage

class TaskViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //Properties
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    
    var task: Task?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Handle the text field’s user input through delegate callbacks.
        nameTextField.delegate = self
        
        // Set up views if editing an existing task.
        if let task = task {
            navigationItem.title = task.name
            nameTextField.text = task.name
            photoImageView.image = task.photo
            
        }
        
        
        // Enable the Save button only if the text field has a valid Meal name.
        updateSaveButtonState()
        
    }
    
    //UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }// end func textFieldShouldReturn
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //pressing done on keyboard updates Title
        //Disables the save button
        
        saveButton.isEnabled = false
        updateSaveButtonState()
        navigationItem.title = textField.text
        
        
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
    
    //Navigation
    
    //when cancel button pressed, goes back
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        //dismiss(animated: true, completion: nil)
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The TaskViewController is not inside a navigation controller.")
        }
    }//end func cancel
    
    
    // This method lets you configure a view controller before it's presented.
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = nameTextField.text ?? ""
        let photo = photoImageView.image
        
        // Set the meal to be passed to MealTableViewController after the unwind segue.
        task = Task(name: name, photo: photo)
    }
    
    
    
    
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
    
    //private Methods
    
    private func updateSaveButtonState(){
        // Disable the Save button if the text field is empty.
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
        
    }
    
}

