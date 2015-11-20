//
//  IssueCell.swift
//  SilverQuill
//
//  Created by SmartPhoneClub on 11/19/15.
//  Copyright © 2015 SmartPhoneClub. All rights reserved.
//

import UIKit

class IssueCell: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet var cover: UIImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
