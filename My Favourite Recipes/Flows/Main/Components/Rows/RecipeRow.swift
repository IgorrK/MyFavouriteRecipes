//
//  RecipeRow.swift
//  My Favourite Recipes
//
//  Created by Igor Kulik on 06.12.2021.
//

import SwiftUI
import Model

struct RecipeRow: View {
    
    // MARK: - Properties
    
    var recipe: Recipe
    @Binding var isFavourite: Bool
    
    // MARK: - View
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 4.0) {
                Text("\(recipe.name)")
                    .font(.headline)
                    .foregroundColor(Color.blue)
                    .bold()
                Image(uiImageOrNil: recipe.country.image)?
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24.0, height: 24.0)
            }
            Spacer()
            
            Button(action: {
                self.isFavourite.toggle()
            }) {
                Image(systemName: self.isFavourite ? "star.fill" : "star")
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

struct RecipeRow_Previews: PreviewProvider {
    static var previews: some View {
        List {
            RecipeRow(recipe: Recipe.mockItem,
                      isFavourite: .constant(false))
        }
    }
}
