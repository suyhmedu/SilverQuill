//
//  Version.swift
//  SilverQuill
//
//  Created by Isaac Eaton on 12/5/15.
//  Copyright © 2015 SmartPhoneClub. All rights reserved.
//

import Foundation

class Version: NSObject, NSCoding, Comparable {
    
    //major, minor, and patch version numbers
    var major: Int
    var minor: Int
    var patch: Int
    
    //display in format major.minor.patch
    override var description: String {
        return "\(major).\(minor).\(patch)"
    }
    
    //initialize with each int defined
    init(major: Int, minor: Int, patch: Int) {
        self.major = major
        self.minor = minor
        self.patch = patch
    }
    
    //initialize from dot separated string
    convenience init(dotSeparated: String) {
        let vlist = dotSeparated.componentsSeparatedByString(".")
        
        let maj = Int(vlist[0])!
        let min = Int(vlist[1])!
        let pat = Int(vlist[2])!
        
        self.init(major: maj, minor: min, patch: pat)
    }
    
    
    //tell decoder how to decode each field and reassemble
    required convenience init?(coder aDecoder: NSCoder) {
        let maj = aDecoder.decodeObjectForKey("major") as! Int
        let min = aDecoder.decodeObjectForKey("minor") as! Int
        let pat = aDecoder.decodeObjectForKey("patch") as! Int
        self.init(major: maj, minor: min, patch: pat)
    }
    
    //tell encoder how to encode each object
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(major, forKey: "major")
        coder.encodeObject(minor, forKey: "minor")
        coder.encodeObject(patch, forKey: "patch")
    }
    
}

//defines check for equality
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

//defines check for less than
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