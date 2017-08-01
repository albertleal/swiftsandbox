//
//  WellcomeViewModel.swift
//  Sandbox
//
//  Created by Albert Leal Gibert on 01/08/2017.
//  Copyright © 2017 Albert Leal Gibert. All rights reserved.
//

import Foundation
class WellcomeViewModel{
    private var wellcomeModel : WellcomeModel
    
    init(){
        self.wellcomeModel = WellcomeModel()
    }
    
    init(withModel model: WellcomeModel){
        self.wellcomeModel = model
    }
    
    var getTitle: String {
        return self.wellcomeModel.title
    }
}
