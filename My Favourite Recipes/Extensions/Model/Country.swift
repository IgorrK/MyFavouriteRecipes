//
//  Country.swift
//  My Favourite Recipes
//
//  Created by Igor Kulik on 11.12.2021.
//

import Foundation
import Model

// MARK: - Mock data
extension Country {
    static var mockItems: [Country] {
        return [
            Country(id: "IT", name: "Italy", flagEmoji: "🇮🇹"),
            Country(id: "GR", name: "Greece", flagEmoji: "🇬🇷"),
            Country(id: "GB", name: "Great Britain", flagEmoji: "🇬🇧"),
            Country(id: "CN", name: "China", flagEmoji: "🇨🇳"),
            Country(id: "FR", name: "France", flagEmoji: "🇫🇷"),
            Country(id: "US", name: "USA", flagEmoji: "🇺🇸"),
            Country(id: "MX", name: "Mexico", flagEmoji: "🇲🇽"),
            Country(id: "ES", name: "Spain", flagEmoji: "🇪🇸")
        ]
    }
}
