//
//  RecipeRouter.swift
//  My Favourite Recipes
//
//  Created by Igor Kulik on 09.12.2021.
//

import Foundation
import SwiftUI
import Model

enum RecipesRoute: RouteType {
    case details(recipe: Recipe)
    case addRecipe
}

struct RecipesRouter: Routing {

    // MARK: - Properties
    
    var dataStorage: RecipeDataStorage

    // MARK: - Routing
    
    func view(for route: RecipesRoute) -> some View {
        switch route {
        case .details(let recipe):
            let viewModel = RecipeDetailViewModel(dataStorage: dataStorage, recipe: recipe)
            RecipeDetailView(viewModel: viewModel)
        case .addRecipe:
            let viewModel = AddRecipeViewModel()
            AddRecipeView(viewModel: viewModel)
        }
    }
}

