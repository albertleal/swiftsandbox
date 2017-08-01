//
//  OnBoardingModel.swift
//  Sandbox
//
//  Created by Albert Leal Gibert on 01/08/2017.
//  Copyright © 2017 Albert Leal Gibert. All rights reserved.
//

import Foundation
protocol OnBoardingModelDelegate : class  {
    var wellcomeModel: WellcomeModel? {get}
    var signInModel: SignInModel? {get}
}
class OnBoardingModel: OnBoardingModelDelegate, ModelDelegate{
    var wellcomeModel: WellcomeModel?
    var signInModel: SignInModel?
    var title: String?
}
