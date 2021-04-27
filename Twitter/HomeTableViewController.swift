//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Sophia Lui on 4/27/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    @IBAction func onLogout(_ sender: Any) {
        // API Folder >> Call twitter api to logout
        TwitterAPICaller.client?.logout()
        
        // Transition back to login screen
        self.dismiss(animated: true, completion:nil)
        
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //adnaskjdnakjdnaknjadkjasndk
        
        // action for logout button, click on it and maintains the action <logged out> 

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

}
