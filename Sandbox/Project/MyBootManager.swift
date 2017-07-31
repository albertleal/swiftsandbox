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


class MyBootManager : FlowCoordinatorManager{
    var configurations: [CoordinableStoryBoard]
    
    required init(){
        self.configurations = [CoordinableStoryBoard]()
        self.configurations.append(CoordinableStoryBoard(isDefault: true, priority: ._default, sotoryBoardId: "Public", conditional: {true}))
        self.configurations.append(CoordinableStoryBoard(isDefault: false, priority: ._normal,sotoryBoardId: "Private", conditional: {true}))
        self.configurations.append(CoordinableStoryBoard(isDefault: false, priority: ._mandatory, sotoryBoardId: "MandatoryUpdate", conditional: {false}))
        self.configurations.append(CoordinableStoryBoard(isDefault: false, priority: ._bloquer, sotoryBoardId: "Mantainance", conditional: {false}))
    }
}
