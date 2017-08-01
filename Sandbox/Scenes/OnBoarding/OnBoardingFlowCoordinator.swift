//
//  PublicFlowController.swift
//  Sandbox
//
//  Created by Albert Leal Gibert on 01/08/2017.
//  Copyright © 2017 Albert Leal Gibert. All rights reserved.
//

import Foundation
class OnBoardingFlowCoordinator : FlowCoordinator,
    WellcomeViewCoordinableDelegate
{
    private var onBoardingModel : OnBoardingFlowModel?
    
    func nextStep(controller: WellcomeViewController) {
        self.onBoardingModel = self.flowModel as? OnBoardingFlowModel
        self.onBoardingModel?.userName = "tontorron"
        
        //call to force step
        self.step(fromCoordinable: controller)
    }
    
    
}
protocol WellcomeViewCoordinableDelegate: class{
    func nextStep(controller: WellcomeViewController)
}
