//
//  PublicFlowModel.swift
//  Sandbox
//
//  Created by Albert Leal Gibert on 01/08/2017.
//  Copyright © 2017 Albert Leal Gibert. All rights reserved.
//

import Foundation
class OnBoardingFlowModel : FlowCoordinatorModel{
    var storyBoardOptions: [String : CoordinableStoryBoard]?
    var sieguesOptions: [String: CoordinableSiegues]?
    
    var onBoardingModel: OnBoardingModel
    
    required init(){
        //make the keys accesible by id, so we can trigger it from protocols
        self.onBoardingModel = OnBoardingModel()
        
        self.sieguesOptions = [ "first" : CoordinableSiegues(priority: ._onStart, sieguedId: "toSecondPage", conditional: {true})]
    }
}
