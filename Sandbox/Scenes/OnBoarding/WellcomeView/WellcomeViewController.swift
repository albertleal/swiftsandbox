//
//  ViewController.swift
//  Sandbox
//
//  Created by Albert Leal Gibert on 30/07/2017.
//  Copyright © 2017 Albert Leal Gibert. All rights reserved.
//

import UIKit

class WellcomeViewController: Coordinable {
    override func awakeFromNib() {
        self.coordinator = OnBoardingFlowCoordinator(withFlowModel: OnBoardingFlowModel(), onCoordinable: self)
    }
    override func loadView() {
        super.loadView()
        self.viewModel = WellcomeViewModel()
    }
    @IBAction func loginButtontTapped(_ sender: UIButton) {
        let coordinator = (self.coordinator as! OnBoardingFlowCoordinator)
        coordinator.nextStep(withModel: (self.viewModel?.model)!, coordinable: self)
    }
    
}
