//
//  PublicFlowController.swift
//  Sandbox
//
//  Created by Albert Leal Gibert on 01/08/2017.
//  Copyright © 2017 Albert Leal Gibert. All rights reserved.
//

import Foundation
class OnBoardingFlowCoordinator : FlowCoordinator, WellcomeViewCoordinableDelegate, LoginViewCoordinableDelegate {
    private var onBoardingFlowModel : OnBoardingFlowModel?

    func nextStep(withModel model: ModelDelegate, coordinable: WellcomeViewController) {
        print("nextStep\t\tWellcomeViewController")
        self.onBoardingFlowModel?.onBoardingModel.wellcomeModel = (model as! WellcomeModel)
        self.performTransition(transition: FlowTransition.popUp("toSecondPage"))
    }
    
    func nextStep(withModel model: ModelDelegate, coordinable: SignInViewController) {
        print("nextStep\t\tWellcomeViewController")
        
        self.onBoardingFlowModel?.onBoardingModel.signInModel = (model as! SignInModel)
        self.performTransition(transition: FlowTransition.popUp("toPrivateStoryBoard"))
    }
}

protocol WellcomeViewCoordinableDelegate: class{
    func nextStep(withModel model: ModelDelegate, coordinable: WellcomeViewController)
}

protocol LoginViewCoordinableDelegate: class{
    func nextStep(withModel model: ModelDelegate, coordinable: SignInViewController)
}
