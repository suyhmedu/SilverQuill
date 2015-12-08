//
//  Issue.swift
//  SilverQuill
//
//  Created by SmartPhoneClub on 11/23/15.
//  Copyright © 2015 SmartPhoneClub. All rights reserved.
//

import UIKit
import CoreData

//class Issue {
class Issue: NSManagedObject {
    
    //metadata and ui properties
    @NSManaged var uniqueID: String
    @NSManaged var title: String
    @NSManaged var cover: UIImage
    @NSManaged var date: String
    
    //file properties
    @NSManaged var webLocation: NSURL
    @NSManaged var fileLocation: String?
    @NSManaged var fileType: String
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    func quickSet(id: String, title: String, cover: UIImage, date: String, webLocation: NSURL, fileLocation: String?, fileType: String) {
        
        self.uniqueID = id
        self.title = title
        self.cover = cover
        self.date = date
        self.webLocation = webLocation
        self.fileLocation = fileLocation
        self.fileType = fileType
    }
    
}
