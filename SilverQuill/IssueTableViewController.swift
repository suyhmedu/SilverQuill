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
    
    //MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //check for updates
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        delegate.updateData()
        
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

    //get the number of rows in the table view
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return issues.count
    }

    //create cell for each issue
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "IssueTableViewCell"
        
        //create cell and load corresponding issue
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! IssueTableViewCell
        let issue = issues[indexPath.row]
        
        //assign properties
        cell.issue = issue
        cell.title.text = "SQ: " + issue.title
        cell.cover.image = issue.cover
        cell.date.text = issue.date
        
        
        cell.controller = self
        
        //check if file is downloaded
        if issue.fileLocation != nil {
            //if yes, set up for viewing
            cell.bdv.addTarget(cell, action: "viewIssue:", forControlEvents: .TouchUpInside)
            cell.bdv.setTitle("View", forState: .Normal)
        } else {
            //otherwise, set up for downloading
            cell.bdv.addTarget(cell, action: "downloadIssue:", forControlEvents: .TouchUpInside)
            cell.bdv.setTitle("Download", forState: .Normal)
        }
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let confirmAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete" , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            
            let deleteAlert = UIAlertController(title: "Are you sure you want to delete this issue?", message: "This issue will be removed from your device and you will have to download it again to access it.", preferredStyle: UIAlertControllerStyle.Alert)
            
            let cancelDelete = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            
            let confirmDelete = UIAlertAction(title: "Delete", style: .Default, handler: { (action: UIAlertAction!) in
                self.deleteIssue(tableView, forRowAtIndexPath: indexPath)
            })
            
            deleteAlert.addAction(cancelDelete)
            deleteAlert.addAction(confirmDelete)
            
            self.presentViewController(deleteAlert, animated: true, completion: nil)
        })
        
        return [confirmAction]
        
    }
    
    //loads the issues from coredata into local array
    func loadIssues() {
        
        //create the request
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = delegate.managedObjectContext
        let request = NSFetchRequest(entityName: "Issue")
        
        do {
            //attempt the request
            let results = try context.executeFetchRequest(request)
            print("Found \(results.count) issues")
            for item in results {
                issues += [item as! Issue]
            }
            //sort issues by date
            issues.sortInPlace {$0.date.compare($1.date) == .OrderedDescending}
        } catch {
            print("Could not execute search for issues: \(error)")
        }
        
    }
    
    func deleteIssue(tableView: UITableView, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = self.tableView(tableView, cellForRowAtIndexPath: indexPath) as! IssueTableViewCell
        let issue = cell.issue
        do {
            let docs = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
            let url = docs.URLByAppendingPathComponent(issue.fileLocation!)
            try NSFileManager.defaultManager().removeItemAtURL(url)
            
            issue.fileLocation = nil
            
            try issue.managedObjectContext!.save()
            
            cell.bdv.addTarget(cell, action: "downloadIssue:", forControlEvents: .TouchUpInside)
            cell.bdv.setTitle("Download", forState: .Normal)
        } catch {
            print("Failed to delete file: \(error)")
        }
        
    }
    
    //MARK: - Navigation
    
    //prepare view for segue into web viewer
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        //get the destination location
        let destNav = segue.destinationViewController as! UINavigationController
        let dest = destNav.childViewControllers.last as! PDFViewController

        //get the cell containing the button and pull data from it
        if let button = sender as? UIButton {
            let cell = button.superview?.superview as! IssueTableViewCell
            
            dest.location = cell.issue.fileLocation
            dest.navbar.title! = "Silver Quill: " + cell.issue.title
        }
        
    }
    
    //return to this controller when exiting the settings
    @IBAction func exitSettings(segue: UIStoryboardSegue) {
    }
    
    //return to this controller when exiting the issue viewer
    @IBAction func returnToTable(segue: UIStoryboardSegue) {
    }
    
}
