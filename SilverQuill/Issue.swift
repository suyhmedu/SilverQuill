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
    
    //properties also stored in coredata
    @NSManaged var uniqueID: String
    @NSManaged var title: String
    @NSManaged var cover: UIImage
    @NSManaged var date: String
    
    @NSManaged var fileLocation: NSURL?
    @NSManaged var fileType: String
    
    @NSManaged var webLocation: String
    
    //var dataURL: NSURL?
    
    convenience init(id: String, title: String, cover: UIImage?, date: String, entity: NSEntityDescription, insertIntoContext: NSManagedObjectContext) {
        
        //init with inherited initializer
        self.init(entity: entity, insertIntoManagedObjectContext: insertIntoContext)
        
        //assign values to properties
        self.uniqueID = id
        self.title = title
        self.cover = cover!
        self.date = date
        
    }
    
}
