//
//  SignInViewModel.swift
//  Sandbox
//
//  Created by Albert Leal Gibert on 01/08/2017.
//  Copyright © 2017 Albert Leal Gibert. All rights reserved.
//

import Foundation


class SignInViewModel: ViewModelDelegate{
    var model: ModelDelegate
    required init() {
        self.model = SignInModel()
    }
    
    var username: String? {
        get{
            return (self.model as! SignInModel).username
        }
        set(newValue){
            (self.model as! SignInModel).password = newValue
        }
    }
    
    var password: String? {
        get{
            return (self.model as! SignInModel).password
        }
        set(newValue){
            (self.model as! SignInModel).password = newValue
        }
    }
    
}
