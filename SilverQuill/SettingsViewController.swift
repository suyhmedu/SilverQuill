//
//  SettingsTableViewController.swift
//  SilverQuill
//
//  Created by Isaac Eaton on 12/2/15.
//  Copyright © 2015 SmartPhoneClub. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func restorePurchases(sender: AnyObject) {
        print("Restore Purchases")
    }
    
    @IBAction func subscribeFree(sender: AnyObject) {
        print("Subscribe Free")
    }
    
    @IBAction func toggleAutoRemove(sender: UISwitch) {
        print("Auto Remove: \(sender.on)")
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 1) {
            return 2;
        }
        return 1;
    }

}
