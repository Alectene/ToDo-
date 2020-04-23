//
//  Task.swift
//  ToDo!
//
//  Created by Alec Tenefrancia on 4/22/20.
//  Copyright © 2020 Alec Tenefrancia. All rights reserved.
//

import UIKit

class Task {
    
    //MARK: Properties
    
    var name: String
    var photo: UIImage?
   
    //MARK: Initialization
     
    init?(name: String, photo: UIImage?) {
        
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        // Initialize stored properties.
           self.name = name
           self.photo = photo
        
    }
}
