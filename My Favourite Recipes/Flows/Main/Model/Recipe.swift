//
//  Recipe.swift
//  My Favourite Recipes
//
//  Created by Igor Kulik on 06.12.2021.
//  Copyright © 2021 Packt. All rights reserved.
//

import Foundation

struct Recipe: Identifiable, Hashable {
    var id = UUID()
    var name = ""
    var origin = ""
    var isFavourite: Bool = false
    var countryCode = ""
    var ingredients = [String]()
    var recipe = ""
}

// MARK: - Mock data

extension Recipe {
    static var mockItem: Recipe {
        return Recipe(id: UUID(),
                      name: "Italian Pizza Chicken",
                      origin: "Italian",
                      countryCode: "IT",
                      ingredients: mockIngredients,
                      recipe: mockRecipe
        )
    }
    
    static var mockIngredients: [String] {
        return ["1 x Ingredient One",
                "2tbp Ingredient Two",
                "500g Ingredient Three",
                "2 x Ingredient Four"]
    }
    
    static var mockRecipe: String {
        return "Bacon ipsum dolor amet ad frankfurter pork aute nostrud leberkas jowl tenderloin dolore beef ribs. Ex tempor shankle, venison in ut cow deserunt. Do swine andouille, minim quis excepteur non shank eiusmod id buffalo. Duis shankle chuck picanha cow id minim esse. Qui burgdoggen capicola, venison culpa labore pastrami est minim bacon enim.\n\nExcepteur lorem turducken aute, qui ad hamburger chicken buffalo chislic brisket cupidatat pariatur. Jowl fugiat picanha pork belly quis. Ad shankle chuck est tri-tip ribeye sunt. Venison turkey tempor, occaecat beef biltong ut pork. Frankfurter sunt ad buffalo short loin cupidatat ipsum strip steak short ribs. Tri-tip porchetta fatback deserunt aute ut. Laborum nostrud aliquip pancetta deserunt, esse laboris pastrami."
    }
}
