//
//  TaskTableViewCell.swift
//  ToDo!
//
//  Created by Alec Tenefrancia on 4/22/20.
//  Copyright © 2020 Alec Tenefrancia. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    //Properties
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
