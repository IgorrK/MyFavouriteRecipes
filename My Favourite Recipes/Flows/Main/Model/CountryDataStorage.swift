//
//  CountryDataStorage.swift
//  My Favourite Recipes
//
//  Created by Igor Kulik on 11.12.2021.
//

import Foundation
import Model

final class CountryDataStorage: ObservableObject {

    // MARK: - Property
    
    @Published private(set) var countries: [Country] = Country.mockItems

}
