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

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
        
        let cover5 = UIImage(named: "issue5")
        let issue5 = Issue(title: titlePrefix + "Lucid", cover: cover5, date: "2015")
        
        let cover1 = UIImage(named: "issue1")
        let issue1 = Issue(title: titlePrefix + "Aurora", cover: cover1, date: "2013")
        
        let cover2 = UIImage(named: "issue2")
        let issue2 = Issue(title: titlePrefix + "Rhapsody", cover: cover2, date: "2012")
        
        let cover3 = UIImage(named: "issue3")
        let issue3 = Issue(title: titlePrefix + "Abstraction", cover: cover3, date: "2011")
        
        let cover4 = UIImage(named: "issue4")
        let issue4 = Issue(title: titlePrefix + "Ink Track", cover: cover4, date: "2010")
        
        issues += [issue5, issue1, issue2, issue3, issue4]
        
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
