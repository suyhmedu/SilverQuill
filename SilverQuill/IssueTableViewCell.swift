//
//  IssueTableViewCell.swift
//  SilverQuill
//
//  Created by SmartPhoneClub on 11/23/15.
//  Copyright © 2015 SmartPhoneClub. All rights reserved.
//

import UIKit

class IssueTableViewCell: UITableViewCell, NSURLSessionDownloadDelegate {

    @IBOutlet var title: UILabel!
    @IBOutlet var cover: UIImageView!
    @IBOutlet var date: UILabel!
    @IBOutlet var bdv: UIButton!
    @IBOutlet var progressBar: UIProgressView!
    @IBOutlet var downLabel: UILabel!
    
    @IBOutlet var issue: Issue!
    var task: NSURLSessionTask!
    
    lazy var session: NSURLSession = {
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        config.allowsCellularAccess = false
        let session = NSURLSession(configuration: config, delegate: self, delegateQueue: NSOperationQueue.mainQueue())
        return session
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        /* Add a 2px red border to each cover
        cover.layer.borderColor! = Constants.BlazerRed.CGColor
        cover.layer.borderWidth = 2.0
        // */
        
        //bdv.titleLabel!.textColor = Constants.BlazerRed
        
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
        
        var url: NSURL?
        if issue.webLocation == "" {
            url = NSURL(string: "https://silverquill.mbhs.edu/magazines/smalltestfile.dat")
        } else {
            url = NSURL(string: issue.webLocation)
        }
        
        let req = NSMutableURLRequest(URL: url!)
        self.task = self.session.downloadTaskWithRequest(req)
        
        //start download
        self.task.resume()
        
        progressBar.hidden = false
        downLabel.hidden = false
        bdv.setTitle("Cancel", forState: .Normal)
        bdv.addTarget(self, action: "cancelDownload:", forControlEvents: .TouchUpInside)
        

        
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
            
            issue.fileLocation = destinationUrl
            
            print(issue)
            bdv.removeTarget(nil, action: nil, forControlEvents: .AllEvents)
            bdv.addTarget(self, action: "viewIssue:", forControlEvents: .TouchUpInside)
            bdv.setTitle("View", forState: .Normal)
            
        } catch {
            print("Error saving file: \(error)")
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
    
    @IBAction func viewIssue(sender: AnyObject) {
        print("view issue at \(issue.fileLocation)" )
    }
    
}
