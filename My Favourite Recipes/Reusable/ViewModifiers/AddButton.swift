//
//  AddButton.swift
//  My Favourite Recipes
//
//  Created by Igor Kulik on 09.12.2021.
//  Copyright © 2021 Packt. All rights reserved.
//

import Foundation
import SwiftUI

struct AddButton: ViewModifier {
    
    // MARK: - Properties
    
    var onAction: () -> Void
    
    // MARK: - ViewModifier
    
    public func body(content: Content) -> some View {
        HStack {
            content
            
            Button(action: {
                onAction()
            }) {
                Image(systemName: "plus")
                    .foregroundColor(.systemTint)
            }
            .padding(.trailing, 8)
        }
    }
}
