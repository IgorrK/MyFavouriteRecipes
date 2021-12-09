//
//  RecipeData.swift
//  My Favourite Recipes
//
//  Created by Igor Kulik on 07.12.2021.
//  Copyright © 2021 Packt. All rights reserved.
//

import Foundation

final class RecipeData: ObservableObject {
    
    // MARK: - Property
    
    @Published private(set) var recipes: [Recipe] = []
        
    // MARK: - Public methods
    
    func addItems(from contentsOf: [Recipe]) {
        recipes.append(contentsOf: contentsOf)
    }
    
    func setItems(from contentsOf: [Recipe]) {
        recipes = contentsOf
    }
    
    func addItems(_ item: Recipe) {
        recipes.append(item)
    }
    
    func set(favourite: Bool, recipe: Recipe) {
        guard let index = recipes.firstIndex(of: recipe) else { return }
        var newItem = recipes[index]
        newItem.isFavourite = favourite
        recipes[index] = newItem
    }
}