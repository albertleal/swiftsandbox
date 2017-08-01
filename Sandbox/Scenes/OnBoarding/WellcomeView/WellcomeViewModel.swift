//
//  WellcomeViewModel.swift
//  Sandbox
//
//  Created by Albert Leal Gibert on 01/08/2017.
//  Copyright © 2017 Albert Leal Gibert. All rights reserved.
//

import Foundation
class WellcomeViewModel: ViewModelDelegate{
    var model: ModelDelegate
    required init() {
        self.model = WellcomeModel()
    }
}
