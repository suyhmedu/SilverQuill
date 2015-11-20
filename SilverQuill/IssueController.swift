//
//  ViewController.swift
//  SilverQuill
//
//  Created by SmartPhoneClub on 11/6/15.
//  Copyright © 2015 SmartPhoneClub. All rights reserved.
//

import UIKit

class IssueController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    // MARK: Properties
    
    var issues: [String] = ["Aurora","Rhapsody","Abstraction","Ink Track"]
    var years: [Int] = [2013,2012,2011,2010]
    
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "IssueCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.issues.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("IssueCell") as! IssueCell
        cell
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }

}

