//
//  IssueTableViewCell.swift
//  SilverQuill
//
//  Created by SmartPhoneClub on 11/23/15.
//  Copyright © 2015 SmartPhoneClub. All rights reserved.
//

import UIKit

class IssueTableViewCell: UITableViewCell {

    @IBOutlet var title: UILabel!
    @IBOutlet var cover: UIImageView!
    @IBOutlet var date: UILabel!
    @IBOutlet var bdv: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        /* Add a 2px red border to each cover
        cover.layer.borderColor! = Constants.BlazerRed.CGColor
        cover.layer.borderWidth = 2.0
        */
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func downloadIssue(sender: AnyObject) {
        
    }

    @IBAction func viewIssue(sender: AnyObject) {
        
    }
}
