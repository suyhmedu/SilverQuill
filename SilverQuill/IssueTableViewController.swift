//
//  IssueTableViewController.swift
//  SilverQuill
//
//  Created by SmartPhoneClub on 11/23/15.
//  Copyright © 2015 SmartPhoneClub. All rights reserved.
//

import UIKit

class IssueTableViewController: UITableViewController {
    
    var issues = [Issue]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        loadIssues()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    @IBAction func exitSettings(segue: UIStoryboardSegue) {
    }

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

        return cell
    }
    
    func loadIssues() {
        let titlePrefix = "SQ: "
        
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let json = delegate.json
        
        for issue in (json["issues"] as! [[String: String]]) {
            let uniqueID = issue["uniqueID"]!
            let title = titlePrefix + issue["title"]!
            let date = issue["date"]!
            
            let imgData = delegate.fetchDataFromUrl(issue["coverUrl"]!)
            let cover = UIImage(data: imgData!)
            
            self.issues += [Issue(id: uniqueID, title: title, cover: cover, date: date)]
            
            issues.sortInPlace { $0.uniqueID.compare($1.uniqueID) == .OrderedDescending}
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
