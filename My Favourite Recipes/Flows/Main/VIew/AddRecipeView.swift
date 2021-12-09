//
//  AddRecipeView.swift
//  My Favourite Recipes
//
//  Created by Igor Kulik on 09.12.2021.
//  Copyright © 2021 Packt. All rights reserved.
//

import SwiftUI

struct AddRecipeView: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: AddRecipeViewModel
    
    @State private var recipeName: String = ""
    @State private var ingredient: String = ""
    
    // MARK: - View
    
    var body: some View {
        Form {
            Section(header: Text("Add Recipe Name:")) {
                TextField("enter recipe name", text: $recipeName)
            }
            
            Section(header: Text("Add Ingredient:")) {
                TextField("enter ingredient name", text: $ingredient)
                    .if(!ingredient.isEmpty) { view in
                        view.modifier(AddButton(onAction: {
                            viewModel.addIngredient(ingredient)
                            ingredient = ""
                        }))
                    }
            }
            
            if viewModel.ingredients.count > 0 {
                Section(header: Text("Current Ingredients:")) {
                    List(viewModel.ingredients, id: \.self) { ingredient in
                        HStack(spacing: 8.0) {
                            Button(action: {
                                viewModel.removeIngredient(ingredient)
                            }) {
                                Image(systemName: "minus")
                                    .foregroundColor(Color(UIColor.opaqueSeparator))
                            }
                            
                            Text(ingredient)
                        }
                        
                    }
                }
            }
        }
    }
}

struct AddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeView(viewModel: AddRecipeViewModel())
    }
}
