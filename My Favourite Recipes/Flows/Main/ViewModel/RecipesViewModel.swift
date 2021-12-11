//
//  RecipesViewModel.swift
//  My Favourite Recipes
//
//  Created by Chris Barker on 20/11/2019.
//

import UIKit
import SwiftUI
import Combine
import Model

final class RecipesViewModel: Identifiable, ObservableObject {
    
    // MARK: - Properties
    
    @ObservedObject var storage: RecipeDataStorage
    
    private var cancellable: AnyCancellable?
    
    @Published var listDataSource = [Recipe]()
    
    @Published var listType: ListType = .default {
        didSet { updateListDataSource(with: storage.recipes) }
    }
    
    var selectedIndex: Int = 0 {
        didSet {
            if let listType = ListType(rawValue: selectedIndex) {
                self.listType = listType
            }
        }
    }
    
    var id = UUID()
        
    init(dataStorage: RecipeDataStorage) {
        self.storage = dataStorage
        cancellable = self.storage.$recipes.sink { [weak self] data in
            self?.updateListDataSource(with: data)
        }
        loadData()
    }
    
    // MARK: - Public methods
    
    func set(favourite: Bool, for recipe: Recipe) {
        storage.set(favourite: favourite, recipe: recipe)
    }
        
    // MARK: - Private mtehods
    
    private func loadData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            var recipes = [Recipe]()
            recipes.append(Recipe(name: "Italian Pizza Chicken", origin: "Italian", country: Country(id: "IT", name: "Italy", flagEmoji: "🇮🇹"), ingredients: Recipe.mockIngredients, recipe: Recipe.mockRecipe))
            recipes.append(Recipe(name: "Greek Pasta Bake", origin: "Greek", country: Country(id: "GR", name: "Greece", flagEmoji: "🇬🇷"), ingredients: Recipe.mockIngredients, recipe: Recipe.mockRecipe))
            recipes.append(Recipe(name: "Hearty Parsnip Soup", origin: "British", country: Country(id: "GB", name: "Great Britain", flagEmoji: "🇬🇧"), ingredients: Recipe.mockIngredients, recipe: Recipe.mockRecipe))
            recipes.append(Recipe(name: "Honey & Soy Salmon", origin: "Chinese", country: Country(id: "CN", name: "China", flagEmoji: "🇨🇳"), ingredients: Recipe.mockIngredients, recipe: Recipe.mockRecipe))
            self?.storage.setItems(from: recipes)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
            var recipes = [Recipe]()
            recipes.append(Recipe(name: "Italian 2", origin: "Italian", country: Country(id: "IT", name: "Italy", flagEmoji: "🇮🇹"), ingredients: Recipe.mockIngredients, recipe: Recipe.mockRecipe))
            recipes.append(Recipe(name: "Greek 2", origin: "Greek", country: Country(id: "GR", name: "Greece", flagEmoji: "🇬🇷"), ingredients: Recipe.mockIngredients, recipe: Recipe.mockRecipe))
            recipes.append(Recipe(name: "British 2", origin: "British", country: Country(id: "GB", name: "Great Britain", flagEmoji: "🇬🇧"), ingredients: Recipe.mockIngredients, recipe: Recipe.mockRecipe))
            self?.storage.addItems(from: recipes)
        }
    }
    
    private func updateListDataSource(with data: [Recipe]) {
        switch listType {
        case .default:
            listDataSource = data
        case .favourites:
            listDataSource = data.filter({ $0.isFavourite })
        }
    }
}

// MARK: - Nested types
extension RecipesViewModel {
    
    enum ListType: Int {
        case `default`
        case favourites
    }
    
    enum Route {
        case details(recipe: Recipe)
        case adddRecipe
    }
}
