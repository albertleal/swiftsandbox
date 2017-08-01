//
//  ViewController.swift
//  Sandbox
//
//  Created by Albert Leal Gibert on 30/07/2017.
//  Copyright © 2017 Albert Leal Gibert. All rights reserved.
//

import UIKit

class WellcomeViewController: Coordinable {
    var viewModel : WellcomeViewModel?;
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting ViewModel
        self.viewModel = WellcomeViewModel()
        
        //Initializing Flow Coordinator
        DispatchQueue.global(qos: .background).async {
            self.coordinator = OnBoardingFlowCoordinator(withFlowModel: OnBoardingFlowModel(), onCoordinable: self)
            DispatchQueue.main.async() {
                self.coordinator!.step(fromCoordinable: self);
            }
        }
        
        // Do any additional setup after loading the view, typically from a nib.
        if(self.viewModel?.getTitle != nil){
            self.navigationItem.title? = (self.viewModel?.getTitle)!
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
