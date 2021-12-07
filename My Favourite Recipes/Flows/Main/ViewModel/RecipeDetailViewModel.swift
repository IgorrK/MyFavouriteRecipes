//
//  RecipeDetailViewModel.swift
//  My Favourite Recipes
//
//  Created by Igor Kulik on 07.12.2021.
//  Copyright © 2021 Packt. All rights reserved.
//

import Foundation

import SwiftUI

final class RecipeDetailViewModel: Identifiable, ObservableObject {
    
    // MARK: - Properties
    
    @ObservedObject var dataStorage: RecipeData
    var recipe: Recipe

    var selectedIndex: Int = 0 {
        didSet {
            if let contentType = ContentType(rawValue: selectedIndex) {
                self.contentType = contentType
            }
        }
    }
    
    @Published var contentType: ContentType = .ingredients


    var id = UUID()
    
    // MARK: - Lifecycle
    
    init(dataStorage: RecipeData, recipe: Recipe) {
        self.dataStorage = dataStorage
        self.recipe = recipe
    }
        
    // MARK: - Public methods
    
    func toggleFavourite() {
        dataStorage.set(favourite: !recipe.isFavourite, recipe: recipe)
    }

    // MARK: - Private mtehods
    

}

// MARK: - Nested types
extension RecipeDetailViewModel {
    
    enum ContentType: Int {
        case ingredients
        case recipe
    }
}
