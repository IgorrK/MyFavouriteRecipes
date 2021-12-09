//
//  RecipesViewModel.swift
//  My Favourite Recipes
//
//  Created by Chris Barker on 20/11/2019.
//  Copyright © 2019 Packt. All rights reserved.
//

import UIKit
import SwiftUI
import Combine

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
            recipes.append(Recipe(id: UUID(), name: "Italian Pizza Chicken", origin: "Italian", countryCode: "IT", ingredients: Recipe.mockIngredients, recipe: Recipe.mockRecipe))
            recipes.append(Recipe(id: UUID(), name: "Greek Pasta Bake", origin: "Greek", countryCode: "GR", ingredients: Recipe.mockIngredients, recipe: Recipe.mockRecipe))
            recipes.append(Recipe(id: UUID(), name: "Hearty Parsnip Soup", origin: "British", countryCode: "GB", ingredients: Recipe.mockIngredients, recipe: Recipe.mockRecipe))
            recipes.append(Recipe(id: UUID(), name: "Honey & Soy Salmon", origin: "Chinese", countryCode: "CN", ingredients: Recipe.mockIngredients, recipe: Recipe.mockRecipe))
            self?.storage.setItems(from: recipes)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
            var recipes = [Recipe]()
            recipes.append(Recipe(id: UUID(), name: "MARIO", origin: "Italian", countryCode: "IT", ingredients: Recipe.mockIngredients, recipe: Recipe.mockRecipe))
            recipes.append(Recipe(id: UUID(), name: "MALAKA", origin: "Greek", countryCode: "GR", ingredients: Recipe.mockIngredients, recipe: Recipe.mockRecipe))
            recipes.append(Recipe(id: UUID(), name: "COCKNEY", origin: "British", countryCode: "GB", ingredients: Recipe.mockIngredients, recipe: Recipe.mockRecipe))
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
