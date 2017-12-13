//
//  JSONModel.swift
//  BNRGitHub
//
//  Created by Alex Johnson on 12/13/17.
//  Copyright © 2017 Alex Johnson. All rights reserved.
//

import UIKit

protocol JSONModelDelegate {
    
    // The model will inform its delegate (the View Controller) that the Repos have been captured
    func repositoriesReady()
}

class JSONModel: NSObject {
    
    // An Array of Repository Objects to pass to the View Controller
    var repositories = [Repository]()
    
    // The View Controller will assign itself as the delegate when it created the JSONModel object
    var delegate:JSONModelDelegate?
    
    // The URL for the GitHub API Call
    // NOTE: Have set the max repos to gather to 500
    let apiURLString: String = "https://api.github.com/users/mps/repos?per_page=500"
    
    // This will hold the JSON Serialization
    var arrayOfRepositoryDictionaries = [[String : AnyObject]]()
   
    // Function to gather make the API call and gather the repository information
    // NOTE: Used Grok Swift guide to Simple REST API Calls in Swift as a reference (Updated: November 10, 2016)
    //   - url = https://grokswift.com/simple-rest-with-swift/
    func getRepositories(){
        
        // Create a URL Object from the URL String
        let apiURL = URL(string: apiURLString)
        
        // Create URLRequest object from the URL
        let apiURLRequest = URLRequest(url: apiURL!)
        
        // Create a URLSession object (??)
        let apiURLSession = URLSession.shared
        
        // Create a dataTask for the Session using the URLRequest
        let task = apiURLSession.dataTask(with: apiURLRequest) {
            (data, response, error) in
            
            do {
                
                // Put the JSON from the API call in the Array of Dictionaries
                self.arrayOfRepositoryDictionaries = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [[String : AnyObject]]
                
                // Loop through the Array of Dictionaries, pulling out individual Repositories
                for counter in 0..<self.arrayOfRepositoryDictionaries.capacity{
                    
                    // Grab Name from current Dictionary
                    let nextName = self.arrayOfRepositoryDictionaries[counter]["name"] as? String
                    
                    // Create new Repository object to add to the array of Repositories
                    let newRepository = Repository()
                    
                    // Set the name of the new Repository object to the name from the current dictionary
                    newRepository.setName(newName: nextName!)
                    
                    // Add the Repository to the Repository List
                    self.repositories.append(newRepository)
                }
                
                // Check to make sure the Model has a delegate
                if let actualDelegate = self.delegate {
                    
                    // Call the delegate's repositoriesReady method
                    actualDelegate.repositoriesReady()
                }
                
            } catch  {
                print("Error")
                return
            }
        }
        task.resume()
    }
}
