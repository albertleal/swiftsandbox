//
//  ViewModel.swift
//  Sandbox
//
//  Created by Albert Leal Gibert on 01/08/2017.
//  Copyright © 2017 Albert Leal Gibert. All rights reserved.
//

import Foundation
// MARK: Model
protocol ModelDelegate: class{
    var title:String?{get set}
}

// MARK: ViewModel
protocol ViewModelDelegate : class{
    var model : ModelDelegate {get}
    var title: String? {get}
    init()
}

extension ViewModelDelegate{
    var title: String?{
        return self.model.title!
    }
}
