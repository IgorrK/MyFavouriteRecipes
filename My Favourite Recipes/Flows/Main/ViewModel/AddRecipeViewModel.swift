//
//  AddRecipeViewModel.swift
//  My Favourite Recipes
//
//  Created by Igor Kulik on 09.12.2021.
//

import Foundation
import Model
import SwiftUI
import Validation
import Combine
import CharacterLimit

final class AddRecipeViewModel: Identifiable, ObservableObject {

    // MARK: - Properties
    
    var id = UUID()
    @Published var input: Input
    @ObservedObject private var countryStorage = CountryDataStorage()
    @ObservedObject private var recipeStorage: RecipeDataStorage

    @Published var countryListDataSource = [Country]()

    private var anyCancellable: AnyCancellable? = nil
    
    var selectedCountry: Country { countryListDataSource[input.selectedCountryIndex] }
    
    // MARK: - Lifecycle
    
    init(recipeStorage: RecipeDataStorage) {
        self.input = Input()
        self.recipeStorage = recipeStorage
        self.countryListDataSource = countryStorage.countries
        self.anyCancellable = input.objectWillChange.sink { [weak self] (_) in
            self?.objectWillChange.send()
        }
    }
    
    // MARK: - Public methods

    func saveRecipeFromInput() {
        var recipeImage = UIImage()
        if let libImage = input.pickedImage {
            recipeImage = libImage
        }
        
        let recipe = Recipe(name: input.name,
                            country: selectedCountry,
                            ingredients: input.ingredients,
                            recipe: input.details,
                            imageData: recipeImage.jpegData(compressionQuality: 0.3) ?? Data())
        recipeStorage.addItem(recipe)
        recipeStorage.saveData()
    }
    
}

// MARK: - Input and Validation
extension AddRecipeViewModel {
    final class Input: ObservableObject {
     
        // MARK: - Lifecycle
        
        @Published var name: String = ""
        @Published var details: String = ""
        @Published var ingredient: String = ""
        
        @Published var ingredientIsValid: Bool = false 

        @Published var ingredients = [String]()
        
        @Published var isSaveEnabled = false

        @Published var selectedCountryIndex = 0
        
        @Published var pickedImage: UIImage?

        // MARK: - Validation
        
        lazy var nameValidation: Validation.Publisher = {
            $name.nonEmptyValidator("Name cannot be empty")
        }()
        
        lazy var detailsValidation: Validation.Publisher = {
            $details.nonEmptyValidator("Recipe cannot be empty")
        }()
        
        lazy var ingredientValidation: Validation.Publisher = {
            $ingredient.nonEmptyValidator()
        }()
        
        lazy var ingredientsValidation: Validation.Publisher = {
            $ingredients.closureValidator { value -> Validation.Status in
                if value.isEmpty {
                    return .failure(message: "Recipe should contain at least one ingredient")
                } else {
                    return .success
                }
            }
        }()
        
        lazy var saveButtonValidation: Validation.Publisher = {
            Validation.Publishers.validateLatest3(nameValidation, detailsValidation, ingredientsValidation)
        }()
        
        lazy var nameCharacterLimit: CharacterLimit.Publisher = {
            $name.characterLimit(40)
        }()
        
        lazy var ingredientCharacterLimit: CharacterLimit.Publisher = {
            $ingredient.characterLimit(40)
        }()
        
        lazy var detailsCharacterLimit: CharacterLimit.Publisher = {
            $details.characterLimit(300)
        }()

        // MARK: - Public methods
        
        func addCurrentIngredient() {
            ingredients.append(ingredient)
            ingredient = ""
        }
        
        func removeIngredient(_ ingredient: String) {
            ingredients.removeAll(where: { $0 == ingredient })
        }
    }
}
