//
//  ViewController.swift
//  ToDo!
//
//  Created by Alec Tenefrancia on 4/21/20.
//  Copyright © 2020 Alec Tenefrancia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    //Properties
    
    @IBOutlet weak var TaskNameLabel: UILabel!
    
    
    @IBOutlet weak var nameTextField: UITextField!
    
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
        TaskNameLabel.text = textField.text
    }//end func textFieldDidEndEditing
    
    //Actions
    
    @IBAction func setDefaultLabelText(_ sender: UIButton) {
        //changes TaskNameLabel to Default Text
        TaskNameLabel.text = "Default Text"
    }
    

}

