//
//  Issue.swift
//  SilverQuill
//
//  Created by SmartPhoneClub on 11/23/15.
//  Copyright © 2015 SmartPhoneClub. All rights reserved.
//

import UIKit
import CoreData

class Issue {
//class Issue: NSManagedObject {
    
    var uniqueID: String
    var title: String
    var cover: UIImage
    var date: String
    
    /*
    @NSManaged var uniqueID: String
    @NSManaged var title: String
    @NSManaged var cover: UIImage
    @NSManaged var date: String
    */
    
    init(id: String, title: String, cover: UIImage?, date: String) {
        
        /*let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = delegate.managedObjectContext
        let entity = NSEntityDescription.entityForName("Issue", inManagedObjectContext: context)
        
        super.init(entity: entity!, insertIntoManagedObjectContext: context)*/

        self.uniqueID = id
        self.title = title
        self.cover = cover!
        self.date = date
        
    }
    
}
