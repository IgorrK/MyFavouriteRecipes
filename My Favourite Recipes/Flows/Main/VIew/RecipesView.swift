//
//  ContentView.swift
//  My Favourite Recipes
//
//  Created by Chris Barker on 19/11/2019.
//  Copyright © 2019 Packt. All rights reserved.
//

import SwiftUI

struct RecipesView: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: RecipesViewModel
    @State var showAddRecipe: Bool = false
    
    // MARK: - View
    
    var body: some View {
        NavigationView {
            VStack {
                Picker(selection: $viewModel.selectedIndex, label: Text("")) {
                    Text("Recipes").tag(0)
                    Text("Favourites").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                List($viewModel.listDataSource) { $recipe in
                    let binding = Binding<Bool>(
                        get: { recipe.isFavourite },
                        set: {
                            self.viewModel.set(favourite: $0, for: recipe)
                        }
                    )
                    NavigationLink(destination: viewModel.view(for: .details(recipe: recipe))) {
                        RecipeRow(recipe: recipe, isFavourite: binding)
                    }
                }
                .animation(nil, value: viewModel.listType)
                .animation(.easeInOut, value: viewModel.listDataSource)
            }
            .navigationBarTitle("My Favourite Recipes")
            .navigationBarItems(trailing:
                                    Button(action: {
                self.showAddRecipe.toggle()
            }) {
                Image(systemName: "plus")
                    .renderingMode(.template)
                    .foregroundColor(.systemTint)
            }.sheet(isPresented: $showAddRecipe) {
                viewModel.view(for: .adddRecipe)
            }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesView(viewModel: RecipesViewModel(dataStorage: RecipeData()))
    }
}
