//
//  Country.swift
//  
//
//  Created by Igor Kulik on 11.12.2021.
//

import Foundation
import UIKit

public struct Country: Identifiable, Hashable {
    
    // MARK: - Lifecycle
    
    public var id: String
    public var name: String
    public var image: UIImage? { UIImage(named: id) }
    public var flagEmoji: String
    
    // MARK: - Lifecycle
    
    public init(id: String, name: String, flagEmoji: String) {
        self.id = id
        self.name = name
        self.flagEmoji = flagEmoji
    }
}
