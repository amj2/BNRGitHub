//
//  Repository.swift
//  BNRGitHub
//
//  Created by Alex Johnson on 12/13/17.
//  Copyright © 2017 Alex Johnson. All rights reserved.
//

import UIKit

// This is the Class to represent the GitHub Repository. Currently we only care about name
class Repository: NSObject {

    private var name = String()
    
    func setName(newName:String){
        name = newName
    }
    
    func getName() -> String{
        return name
    }
    
}
