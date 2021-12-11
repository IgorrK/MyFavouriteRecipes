//
//  UserDefaults.swift
//  My Favourite Recipes
//
//  Created by Igor Kulik on 11.12.2021.
//

import Foundation
import Model

extension UserDefaults {
    private enum UserDefaultsKeys: String {
        case recipes
    }
    
    var recipesData: Data? {
        get {
            return data(forKey: UserDefaultsKeys.recipes.rawValue)
        }
        set {
            set(newValue, forKey: UserDefaultsKeys.recipes.rawValue)
        }
    }
}
