//
//  PDFViewController.swift
//  SilverQuill
//
//  Created by Isaac Eaton on 12/6/15.
//  Copyright © 2015 SmartPhoneClub. All rights reserved.
//

import UIKit

class PDFViewController: UIViewController {
    
    @IBOutlet var navbar: UINavigationItem!
    @IBOutlet var webView: UIWebView!
    
    //location of file, should be passed in prepareforsegue
    var location: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //create a request for the file and load it
        
        let docs = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
        let url = docs.URLByAppendingPathComponent(location!)
        let req = NSURLRequest(URL: url)
        webView.loadRequest(req)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
