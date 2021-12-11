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
    
    @ObservedObject private var storage = CountryDataStorage()
    var id = UUID()

    @Published var ingredients = [String]()
    @Published var countryListDataSource = [Country]()

    // MARK: - Lifecycle
    
    init() {
        self.countryListDataSource = storage.countries
    }
    
    // MARK: - Public methods
    
    func addIngredient(_ ingredient: String) {
        ingredients.append(ingredient)
    }
    
    func removeIngredient(_ ingredient: String) {
        ingredients.removeAll(where: { $0 == ingredient })
    }

}
