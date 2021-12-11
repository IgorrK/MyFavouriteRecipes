//
//  Recipe.swift
//  
//
//  Created by Igor Kulik on 11.12.2021.
//

import Foundation
import UIKit

public struct Recipe: Identifiable, Hashable, Codable {
    
    // MARK: - Properties
    
    public var id = UUID()
    public var name = ""
    public var isFavourite: Bool = false
    public var country: Country
    public var ingredients = [String]()
    public var recipe = ""
    public var imageData: Data?
    public var image: UIImage {
        if let dataImage = UIImage(data: imageData ?? Data()) {
            return dataImage
        } else if let countryImage = UIImage(named: country.id) {
            return countryImage
        }
        return UIImage()
    }
    
    // MARK: - Lifecycle
    
    public init(name: String, country: Country, ingredients: [String], recipe: String, imageData: Data? = nil) {
        self.name = name
        self.country = country
        self.ingredients = ingredients
        self.recipe = recipe
        self.imageData = imageData
    }
}
