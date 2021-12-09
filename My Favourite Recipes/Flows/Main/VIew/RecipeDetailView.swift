//
//  RecipeDetailView.swift
//  My Favourite Recipes
//
//  Created by Igor Kulik on 07.12.2021.
//  Copyright © 2021 Packt. All rights reserved.
//

import SwiftUI

struct RecipeDetailView: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: RecipeDetailViewModel
    
    // MARK: - Lifecycle
    
    // MARK: - View
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            
            Picker(selection: $viewModel.selectedIndex, label: Text("")) {
                Text("Ingredients").tag(0)
                Text("Recipe").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            
            Image(viewModel.recipe.countryCode)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, maxHeight: 200)
            
            HStack {
                // Name of our recipe
                Text("\(viewModel.recipe.name)")
                    .font(.title)
                    .padding(.leading, 10.0)
                // Favourites Button
                Button(action: {
                    viewModel.toggleFavourite()
                }) {
                    Image(systemName: viewModel.recipe.isFavourite ? "star.fill" : "star")
                }
            }
            // Recipe origin
            Text("Origin: \(viewModel.recipe.origin)")
                .font(.subheadline)
                .padding(.leading, 10.0)
            
            switch viewModel.contentType {
            case .ingredients:
                List(viewModel.recipe.ingredients, id: \.self) { ingredient in
                    HStack {
                        Image(systemName: "hand.point.right")
                        Text(ingredient)
                    }
                }
                .listStyle(GroupedListStyle())
            case .recipe:
                ScrollView {
                    Text(viewModel.recipe.recipe)
                        .padding(15.0)
                        .multilineTextAlignment(.leading)
                }
            }
            
            Spacer()
        }
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(viewModel: RecipeDetailViewModel(dataStorage: RecipeDataStorage(), recipe: Recipe.mockItem))
    }
}
