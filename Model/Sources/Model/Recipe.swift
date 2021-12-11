//
//  Recipe.swift
//  
//
//  Created by Igor Kulik on 11.12.2021.
//

import Foundation

public struct Recipe: Identifiable, Hashable {
    
    // MARK: - Properties
    
    public var id = UUID()
    public var name = ""
    public var origin = ""
    public var isFavourite: Bool = false
    public var country: Country
    public var ingredients = [String]()
    public var recipe = ""
    
    // MARK: - Lifecycle
    
    public init(name: String, origin: String, country: Country, ingredients: [String], recipe: String) {
        self.name = name
        self.origin = origin
        self.country = country
        self.ingredients = ingredients
        self.recipe = recipe
    }
}
