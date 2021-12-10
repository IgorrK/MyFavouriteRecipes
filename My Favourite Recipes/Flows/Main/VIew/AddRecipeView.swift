//
//  AddRecipeView.swift
//  My Favourite Recipes
//
//  Created by Igor Kulik on 09.12.2021.
//  Copyright © 2021 Packt. All rights reserved.
//

import SwiftUI
import ImagePicker
struct AddRecipeView: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: AddRecipeViewModel
    
    @State private var recipeName: String = ""
    @State private var ingredient: String = ""
    @State private var showsSourceType = false
    @State private var showsPhotoLibraryPicker = false

    @State private var showsImagePicker = false
    @State private var pickedImage: UIImage?
    @State private var pickerSourceType: UIImagePickerController.SourceType = .photoLibrary
    
    // MARK: - View
    
    var body: some View {
        Form {
            
            Button(action: {
                showsSourceType.toggle()
            }) {
                buttonImage
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.systemTint, lineWidth: 3)
                            .shadow(radius: 10)
                    )
                    .frame(width: UIScreen.Geometry.width / 2.0,
                           height: UIScreen.Geometry.width / 2.0,
                           alignment: .center)
                    .padding(6)
            }
            .buttonStyle(PlainButtonStyle())
            .frame(maxWidth: .infinity)
            .actionSheet(isPresented: $showsSourceType) {
                ActionSheet(title: Text("Choose a source"), buttons: [
                    .default(Text("Photo Library")) {
                        pickerSourceType = .photoLibrary
                        showsImagePicker.toggle()
                    },
                    .default(Text("Camera")) {
                        pickerSourceType = .camera
                        showsImagePicker.toggle()
                    },
                    .cancel()
                ])
            }
            .sheet(isPresented: $showsPhotoLibraryPicker) {
                ImagePicker.picker(sourceType: .camera, selectedImage: $pickedImage)
            }
            .sheet(isPresented: $showsImagePicker) {
                ImagePicker.picker(sourceType: .photoLibrary, selectedImage: $pickedImage)
            }
            
            Section(header: Text("Add Recipe Name:")) {
                TextField("enter recipe name", text: $recipeName)
            }
            
            Section(header: Text("Add Ingredient:")) {
                TextField("enter ingredient name", text: $ingredient)
                    .if(!ingredient.isEmpty) { view in
                        view.modifier(AddButton(onAction: {
                            viewModel.addIngredient(ingredient)
                            ingredient = ""
                        }))
                    }
            }
            
            if viewModel.ingredients.count > 0 {
                Section(header: Text("Current Ingredients:")) {
                    List(viewModel.ingredients, id: \.self) { ingredient in
                        HStack(spacing: 8.0) {
                            Button(action: {
                                viewModel.removeIngredient(ingredient)
                            }) {
                                Image(systemName: "minus")
                                    .foregroundColor(Color(UIColor.opaqueSeparator))
                            }
                            
                            Text(ingredient)
                        }
                        
                    }
                }
            }
        }
        
    }
    
    private var buttonImage: Image {
        if let pickedImage = pickedImage {
            return Image(uiImage: pickedImage)
        } else {
            return Image(systemName: "photo.circle.fill")
        }
    }
}

struct AddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeView(viewModel: AddRecipeViewModel())
    }
}
