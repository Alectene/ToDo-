//
//  Task.swift
//  ToDo!
//
//  Created by Alec Tenefrancia on 4/22/20.
//  Copyright © 2020 Alec Tenefrancia. All rights reserved.
//

import UIKit
import os.log

class Task: NSObject, NSCoding {
    
    
    //MARK: NSCoding
    func encode(with acoder: NSCoder) {
        acoder.encode(name, forKey: PropertyKey.name)
        acoder.encode(photo, forKey: PropertyKey.photo)
    }//end func encode
    
    required convenience init?(coder acoder: NSCoder) {
         // The name is required. If we cannot decode a name string, the initializer should fail.
           guard let name = acoder.decodeObject(forKey: PropertyKey.name) as? String else {
               os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
               return nil
           }
           
           // Because photo is an optional property of task, just use conditional cast.
           let photo = acoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
           
           
           // Must call designated initializer.
           self.init(name: name, photo: photo)
    }
    
    
    //MARK: Properties
    
    var name: String
    var photo: UIImage?
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("tasks")
   
    //MARK: Types
    
    struct PropertyKey{
        
        static let name = "name"
        static let photo = "photo"
        
    }
    
    
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
