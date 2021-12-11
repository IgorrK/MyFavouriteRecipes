//
//  RecipeDataStorage.swift
//  My Favourite Recipes
//
//  Created by Igor Kulik on 07.12.2021.
//

import Foundation
import Model

final class RecipeDataStorage: ObservableObject {
    
    // MARK: - Property
    
    @Published private(set) var recipes: [Recipe]
     
    // MARK: - Lifecycle
    
    init() {
        recipes = Self.loadData()
    }
    
    // MARK: - Private methods
        
    private static func loadData() -> [Recipe] {
        do {
            let data = try UserDefaults.standard.recipesData.unwrap()
            let recipes = try JSONDecoder().decode([Recipe].self, from: data)
            return recipes
        } catch {
            print(error)
            return [Recipe]()
        }
    }
    
    // MARK: - Public methods
    
    func saveData() {
        do {
            let data = try JSONEncoder().encode(recipes)
            UserDefaults.standard.recipesData = data
        } catch {
            print(error)
        }
    }
    
    func addItems(from contentsOf: [Recipe]) {
        recipes.append(contentsOf: contentsOf)
    }
    
    func setItems(from contentsOf: [Recipe]) {
        recipes = contentsOf
    }
    
    func addItem(_ item: Recipe) {
        recipes.append(item)
    }
    
    func set(favourite: Bool, recipe: Recipe) {
        guard let index = recipes.firstIndex(of: recipe) else { return }
        var newItem = recipes[index]
        newItem.isFavourite = favourite
        recipes[index] = newItem
    }
}
