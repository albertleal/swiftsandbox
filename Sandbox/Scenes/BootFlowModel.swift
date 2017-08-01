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


class BootFlowModel : BootCoordinatorModel{
    var storyBoardOptions: [String : CoordinableStoryBoard]?
    
    required init(){        
        self.storyBoardOptions = [
            "onboarding": CoordinableStoryBoard(
                isDefault: true,
                priority: ._default,
                sotoryBoardId: "OnBoarding",
                conditional: {true}
            ),
            "private":  CoordinableStoryBoard(
                isDefault: false,
                priority: ._normal,
                sotoryBoardId: "Private",
                conditional: {false}
            ),
            "mandatoryUpdate": CoordinableStoryBoard(
                isDefault: false,
                priority: ._mandatory,
                sotoryBoardId: "MandatoryUpdate",
                conditional: {false}
            ),
            "mantainance": CoordinableStoryBoard(
                isDefault: false,
                priority: ._bloquer,
                sotoryBoardId: "Mantainance",
                conditional: {false}
            )
        ]
    }
}
