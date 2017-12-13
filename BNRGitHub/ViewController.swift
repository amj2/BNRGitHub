//
//  ViewController.swift
//  BNRGitHub
//
//  Created by Alex Johnson on 12/13/17.
//  Copyright © 2017 Alex Johnson. All rights reserved.
//

import UIKit

class ViewController: UIViewController, JSONModelDelegate {
    
    // Hold the Repositories created from the JSON Model Github extraction
    var pulledRepositories = [Repository]()
    
    // JSONModel class performs API request
    var model = JSONModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the model's delegate to self
        model.delegate = self
        
        // Tell the model to gather the Repositories
        model.getRepositories()
    }
    
    // Delegate method that is called when the model has gathered the repositories
    func repositoriesReady() {
        
        // Copy Repositories
        pulledRepositories = model.repositories
        
        // Perform Segue to TableViewController
        self.performSegue(withIdentifier: "repositoriesLoaded", sender: self)
        
    }
    
    // Before the Segue occurs:
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Set up the segue destination
        let tableVC = segue.destination as! TableViewController
        
        // Copy Repositories to the TableViewController destination
        tableVC.pulledRepositories = pulledRepositories
    }
}
