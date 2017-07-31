//
//  BootManager.swift
//  Sandbox
//
//  Created by Albert Leal Gibert on 30/07/2017.
//  Copyright © 2017 Albert Leal Gibert. All rights reserved.
//

import UIKit
class MyBootManager : BootCoordinatorManager{
    var publicStoryboardID: String = "Public"
    
    var privateStoryboardID: String? = "Private"
    
    var mandatoryUpdateStoryboardID: String? = nil
    
    var mantainanceStoryboardID: String? = nil
    
    required init(){
        
    }
    
    func canNavigateToPrivate() -> Bool {
        return false
    }
    
    func isMandatoryUpdateRequired() -> Bool {
        return false
    }
    
    func isMantainanceRequired() -> Bool {
        return false
    }
}
