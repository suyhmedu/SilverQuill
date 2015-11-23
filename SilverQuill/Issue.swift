//
//  Issue.swift
//  SilverQuill
//
//  Created by SmartPhoneClub on 11/23/15.
//  Copyright © 2015 SmartPhoneClub. All rights reserved.
//

import UIKit

class Issue {
    
    var title: String
    var cover: UIImage
    var date: String
    
    init(title: String, cover: UIImage?, date: String) {
        self.title = title
        self.cover = cover!
        self.date = date
    }
    
}
