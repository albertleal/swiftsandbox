//
//  MyBootManager.swift
//  Sandbox
//
//  Created by Albert Leal Gibert on 30/07/2017.
//  Copyright © 2017 Albert Leal Gibert. All rights reserved.
//
//  Boot Impleentation as an example of Project Boot
//

import UIKit

class MyBootManager : BootCoordinatorManager{
    required init(){
        
    }
    
    // MARK: StoryBoard IDS
    var publicStoryboardID: String = "Public"
    
    var privateStoryboardID: String? = "Private"
    
    var mandatoryUpdateStoryboardID: String? = nil
    
    var mantainanceStoryboardID: String? = nil
    
    // MARK: Public API
    func canNavigateToPrivate() -> Bool {
        //  Implement Logic to controll
        //  user credentials and session
        return true
    }
    
    func isMandatoryUpdateRequired() -> Bool {
        //  Implement Logic to detect
        //  if theres any mandatory update required
        return false
    }
    
    func isMantainanceRequired() -> Bool {
        //  Implement Logic to detect
        //  if theres any down
        //  including backend or third party systems
        return false
    }
}
