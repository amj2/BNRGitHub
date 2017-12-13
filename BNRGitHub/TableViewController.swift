//
//  TableViewController.swift
//  BNRGitHub
//
//  Created by Alex Johnson on 12/13/17.
//  Copyright © 2017 Alex Johnson. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController{
    
    // Hold the Repositories brought over from the View Controller
    // - created originally from the JSON Model Github extraction
    var pulledRepositories = [Repository]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        // The # of rows is equal to the total # of Repositories
        return pulledRepositories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Using the PrototypeCell from the Storyboard, Create or Reuse cell for current IndexPath
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrototypeCell", for: indexPath)
        
        // The TextField property of the Storyboard PrototypeCell has a Tag of 1
        let textField = cell.viewWithTag(1) as? UITextField

        // Check to make sure that there is a Repository for the current IndexPath Row
        if pulledRepositories.count >= indexPath.row{
            
            // Set the text of the TextField to the name of the Corresponding Repository
            textField?.text = pulledRepositories[indexPath.row].getName()
        }
        
        // Return the cell
        return cell
    }
}
