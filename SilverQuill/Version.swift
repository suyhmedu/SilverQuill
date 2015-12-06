//
//  Version.swift
//  SilverQuill
//
//  Created by Isaac Eaton on 12/5/15.
//  Copyright © 2015 SmartPhoneClub. All rights reserved.
//

import UIKit
import CoreData

class Version: NSData {
    
    @NSManaged var major: Int16
    @NSManaged var minor: Int16
    @NSManaged var patch: Int16
    
    override var description: String {
        return "\(major).\(minor).\(patch)"
    }
    
    init(dotSeparated: String, entity: NSEntityDescription, insertIntoManagedObjectContext: NSManagedObjectContext) {
        super.init(entity: entity, insertIntoManagedObjectContext: insertIntoManagedObjectContext)
        
        let vlist = dotSeparated.componentsSeparatedByString(".")
        
        self.major = Int16(vlist[0])!
        self.minor = Int16(vlist[1])!
        self.patch = Int16(vlist[2])!
        
    }
    
}

func ==(lhs: Version, rhs: Version) -> Bool {
    if (lhs.major == lhs.major) {
        if (lhs.minor == lhs.minor) {
            if (lhs.patch == lhs.patch) {
                return true
            }
        }
    }
    return false
}

func <(lhs: Version, rhs: Version) -> Bool {
    if (lhs.major == rhs.minor) {
        if (lhs.minor == rhs.minor) {
            return lhs.patch < rhs.patch
        } else {
            return lhs.minor < lhs.minor
        }
    } else {
        return lhs.major < rhs.minor
    }
}