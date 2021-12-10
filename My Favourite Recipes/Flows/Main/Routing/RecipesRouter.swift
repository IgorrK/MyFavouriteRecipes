//
//  RecipeRouter.swift
//  My Favourite Recipes
//
//  Created by Igor Kulik on 09.12.2021.
//  Copyright © 2021 Packt. All rights reserved.
//

import Foundation
import SwiftUI

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
