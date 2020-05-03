//
//  ToDoTableViewCell.swift
//  Skillbox14_CoreData
//
//  Created by Александр Сорока on 03.05.2020.
//  Copyright © 2020 Александр Сорока. All rights reserved.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    
    @IBOutlet weak var toDoItem: UILabel!
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
