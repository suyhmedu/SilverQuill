//
//  IssueTableViewCell.swift
//  SilverQuill
//
//  Created by SmartPhoneClub on 11/23/15.
//  Copyright © 2015 SmartPhoneClub. All rights reserved.
//

import UIKit

class IssueTableViewCell: UITableViewCell, NSURLSessionDownloadDelegate {

    //ui objects
    @IBOutlet var title: UILabel!
    @IBOutlet var cover: UIImageView!
    @IBOutlet var date: UILabel!
    @IBOutlet var bdv: UIButton!
    @IBOutlet var progressBar: UIProgressView!
    @IBOutlet var downLabel: UILabel!
    
    //data sources
    var issue: Issue!
    var controller: IssueTableViewController!
    
    //task
    var task: NSURLSessionTask!
    
    //when needed create a url session
    lazy var session: NSURLSession = {
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        config.allowsCellularAccess = false
        let session = NSURLSession(configuration: config, delegate: self, delegateQueue: NSOperationQueue.mainQueue())
        return session
    }()
    
    //MARK: Overrides
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        /* Add a 2px red border to each cover
        cover.layer.borderColor! = Constants.BlazerRed.CGColor
        cover.layer.borderWidth = 2.0
        // */
        
        progressBar.setProgress(0.0, animated: true)
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    //MARK: - Downloading
    
    @IBAction func downloadIssue(sender: AnyObject) {
        
        //don't do anything if already downloading
        if self.task != nil {
            self.task = nil
        }
        
        //TODO: after testing, assume file exists
        var url: NSURL?
        if issue.webLocation == "" {
            url = NSURL(string: "https://silverquill.mbhs.edu/magazines/smallpdf.pdf")
        } else {
            url = issue.webLocation
        }
        
        //create request and make download task
        let req = NSMutableURLRequest(URL: url!)
        self.task = self.session.downloadTaskWithRequest(req)
        
        //start download
        self.task.resume()
        
        //set up button for cancelling
        bdv.removeTarget(nil, action: nil, forControlEvents: .AllEvents)
        bdv.addTarget(self, action: "cancelDownload:", forControlEvents: .TouchUpInside)
        bdv.setTitle("Cancel", forState: .Normal)
        
        //reveal ui items
        progressBar.hidden = false
        downLabel.hidden = false
        
    }
    
    @IBAction func cancelDownload(sender: AnyObject) {
        
        if self.task == nil {
            return
        }
        
        progressBar.hidden = true
        progressBar.setProgress(0.0, animated: true)
        downLabel.hidden = true
        bdv.setTitle("Download", forState: .Normal)
        
        //bdv.removeTarget(self, action: "cancelDownload:", forControlEvents: .TouchUpInside)
        bdv.removeTarget(nil, action: nil, forControlEvents: .AllEvents)
        bdv.addTarget(self, action: "downloadIssue:", forControlEvents: .TouchUpInside)
        
        self.task.cancel()
        
    }
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        let totalWritten = Float(totalBytesWritten)
        let totalExpected = Float(totalBytesExpectedToWrite)
        
        progressBar.progress = totalWritten / totalExpected
        
        let writtenMB = totalWritten / 1024 / 1024
        let expectedMB = totalExpected / 1024 / 1024
        
        let text = String(format: "%.1fMB of %.1fMB", writtenMB, expectedMB)
        downLabel.text = text
        
    }
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL) {
        
        let docsDirectoryUrl = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
        print("Finished download")
        
        do {
            let destinationUrl = docsDirectoryUrl.URLByAppendingPathComponent(downloadTask.response!.suggestedFilename!)
            try NSFileManager().moveItemAtURL(location, toURL: destinationUrl)
            print("Saved file at \(destinationUrl)")
            
            issue.fileLocation = downloadTask.response!.suggestedFilename!
            
            //save context
            try issue.managedObjectContext!.save()
            
            //set up button for viewing
            bdv.removeTarget(nil, action: nil, forControlEvents: .AllEvents)
            bdv.addTarget(self, action: "viewIssue:", forControlEvents: .TouchUpInside)
            bdv.setTitle("View", forState: .Normal)
            
        } catch {
            print("Error saving file: \(error)")
            
            //set up button for downloading
            bdv.removeTarget(nil, action: nil, forControlEvents: .AllEvents)
            bdv.addTarget(self, action: "downloadIssue:", forControlEvents: .TouchUpInside)
            bdv.setTitle("Download", forState: .Normal)
        }
        
        progressBar.hidden = true
        downLabel.hidden = true
        
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        if error != nil {
            print("Completed with error: \(error)")
        }
    }
    
    //MARK: - Viewing
    
    //TODO: do this in a less shitty manner
    @IBAction func viewIssue(sender: AnyObject) {
        print("Trying to view: \(issue.fileLocation)")
        self.controller.performSegueWithIdentifier("viewFile", sender: sender)
    }
    
}
