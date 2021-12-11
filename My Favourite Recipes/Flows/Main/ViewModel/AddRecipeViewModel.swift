//
//  AddRecipeViewModel.swift
//  My Favourite Recipes
//
//  Created by Igor Kulik on 09.12.2021.
//

import Foundation
import Model
import SwiftUI

final class AddRecipeViewModel: Identifiable, ObservableObject {

    // MARK: - Properties
    
    @ObservedObject private var countryStorage = CountryDataStorage()
    @ObservedObject private var recipeStorage: RecipeDataStorage
    
    var id = UUID()

    @Published var ingredients = [String]()
    @Published var countryListDataSource = [Country]()

    // MARK: - Lifecycle
    
    init(recipeStorage: RecipeDataStorage) {
        self.recipeStorage = recipeStorage
        self.countryListDataSource = countryStorage.countries
    }
    
    // MARK: - Public methods
    
    func addIngredient(_ ingredient: String) {
        ingredients.append(ingredient)
    }
    
    func removeIngredient(_ ingredient: String) {
        ingredients.removeAll(where: { $0 == ingredient })
    }

    func saveRecipe(name: String, ingredients: [String], recipe: String, country: Country, image: UIImage?) {
        var recipeImage = UIImage()
        if let libImage = image {
            recipeImage = libImage
        }
        
        let recipe = Recipe(name: name,
                            country: country,
                            ingredients: ingredients,
                            recipe: recipe,
                            imageData: recipeImage.jpegData(compressionQuality: 0.3) ?? Data())
        recipeStorage.addItem(recipe)
        recipeStorage.saveData()
    }
}
