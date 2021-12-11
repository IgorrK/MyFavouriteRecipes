//
//  RecipeDetailViewModel.swift
//  My Favourite Recipes
//
//  Created by Igor Kulik on 07.12.2021.
//

import Foundation
import Model
import SwiftUI

final class RecipeDetailViewModel: Identifiable, ObservableObject {
    
    // MARK: - Properties
    
    @ObservedObject var dataStorage: RecipeDataStorage
    
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
    
    init(dataStorage: RecipeDataStorage, recipe: Recipe) {
        self.dataStorage = dataStorage
        self.recipe = recipe
    }
        
    // MARK: - Public methods
    
    func toggleFavourite() {
        dataStorage.set(favourite: !recipe.isFavourite, recipe: recipe)
    }

    // MARK: - Private methods
    

}

// MARK: - Nested types
extension RecipeDetailViewModel {
    
    enum ContentType: Int {
        case ingredients
        case recipe
    }
}
