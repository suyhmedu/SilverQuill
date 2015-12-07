//
//  IssueTableViewController.swift
//  SilverQuill
//
//  Created by SmartPhoneClub on 11/23/15.
//  Copyright © 2015 SmartPhoneClub. All rights reserved.
//

import UIKit
import CoreData

class IssueTableViewController: UITableViewController {
    
    var issues = [Issue]()

    override func viewDidLoad() {
        super.viewDidLoad()

        loadIssues()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //one section in table view
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    //return to this controller when exiting settings
    @IBAction func exitSettings(segue: UIStoryboardSegue) {
        //THIS IS A COMPLETE IMPLEMENTATION
    }

    //get the number of rows in the table view
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return issues.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "IssueTableViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! IssueTableViewCell

        let issue = issues[indexPath.row]
        cell.title.text = issue.title
        cell.cover.image = issue.cover
        cell.date.text = issue.date
        
        cell.issue = issue
        
        print(issue.fileLocation)
        
        if issue.fileLocation != nil {
            cell.bdv.addTarget(cell, action: "viewIssue:", forControlEvents: .TouchUpInside)
            cell.bdv.setTitle("View", forState: .Normal)
        } else {
            cell.bdv.addTarget(cell, action: "downloadIssue:", forControlEvents: .TouchUpInside)
        }
        
        
        return cell
    }
    
    func loadIssues() {
        
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = delegate.managedObjectContext
        let request = NSFetchRequest(entityName: "Issue")
        
        do {
            let results = try context.executeFetchRequest(request)
            print("Found \(results.count) issues")
            for item in results {
                issues += [item as! Issue]
            }
            issues.sortInPlace {$0.uniqueID.compare($1.uniqueID) == .OrderedDescending}
        } catch {
            print("Could not execute search for issues: \(error)")
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
