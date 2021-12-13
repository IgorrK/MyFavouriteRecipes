//
//  AddRecipeView.swift
//  My Favourite Recipes
//
//  Created by Igor Kulik on 09.12.2021.
//

import SwiftUI
import ImagePicker
import Model
import UIKit

struct AddRecipeView: View {
    
    // MARK: - Properties
    
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var viewModel: AddRecipeViewModel
    
    @State private var showsSourceType = false
    @State private var showsImagePicker = false
    @State private var showsPermissionDeniedAlert: Bool = false
    @State private var pickerSourceType: ImagePicker.SourceType = .photoLibrary
    
    // MARK: - View
    
    var body: some View {
        NavigationView {
            Form {
                
                Button(action: {
                    showsSourceType.toggle()
                }) {
                    buttonImage
                        .clipShape(Circle())
                        .frame(width: UIScreen.Geometry.width / 2.0,
                               height: UIScreen.Geometry.width / 2.0,
                               alignment: .center)
                        .padding(6)
                        .animation(.linear, value: viewModel.input.pickedImage)
                }
                .buttonStyle(PlainButtonStyle())
                .frame(maxWidth: .infinity)
                .actionSheet(isPresented: $showsSourceType) {
                    let commonButtonAction: Completion = {
                        ImagePicker.PermissionManager.resolvePermission(for: pickerSourceType) { status in
                            switch status {
                            case .authorized:
                                showsImagePicker.toggle()
                            case .denied:
                                showsPermissionDeniedAlert.toggle()
                            case .notNow:
                                break
                            }
                        }
                    }
                    
                    return ActionSheet(title: Text("Choose a source"), buttons: [
                        .default(Text("Photo Library")) {
                            pickerSourceType = .photoLibrary
                            commonButtonAction()
                        },
                        .default(Text("Camera")) {
                            pickerSourceType = .camera
                            commonButtonAction()
                        },
                        .cancel()
                    ])
                }
                .permissionDeniedAlert(sourceType: pickerSourceType, isPresented: $showsPermissionDeniedAlert)
                .sheet(isPresented: $showsImagePicker) {
                    ImagePicker.picker(sourceType: pickerSourceType, selectedImage: $viewModel.input.pickedImage)
                }
                
                Section(header: Text("Add Recipe Name:")) {
                    TextField("enter recipe name", text: $viewModel.input.name)
                        .validation(viewModel.input.nameValidation)
                }
                
                Section(header: Text("Add Ingredient:")) {
                    HStack {
                        TextField("enter ingredient name", text: $viewModel.input.ingredient)
                            .validation(viewModel.input.ingredientValidation, flag: $viewModel.input.ingredientIsValid)
                            .validation(viewModel.input.ingredientsValidation)
                        
                        if viewModel.input.ingredientIsValid {
                            Button(action: {
                                viewModel.input.addCurrentIngredient()
                                hideKeyboard()
                            }) {
                                Image(systemName: "plus")
                                    .foregroundColor(.systemTint)
                            }
                        }
                    }
                }
                
                if viewModel.input.ingredients.count > 0 {
                    Section(header: Text("Current Ingredients:")) {
                        List(viewModel.input.ingredients, id: \.self) { ingredient in
                            HStack(spacing: 8.0) {
                                Button(action: {
                                    viewModel.input.removeIngredient(ingredient)
                                }) {
                                    Image(systemName: "minus")
                                        .foregroundColor(Color(UIColor.opaqueSeparator))
                                }
                                
                                Text(ingredient)
                            }
                            
                        }
                    }
                }
                
                Section(header: Text("Details")) {
                    detailsTextView(text: $viewModel.input.details)
                        .validation(viewModel.input.detailsValidation)
                        .frame(height: 220)
                }
                
                Section(header: Text("Country of Origin:")) {
                    Picker(selection: $viewModel.input.selectedCountryIndex, label: Text("Country")) {
                        ForEach(Array(viewModel.countryListDataSource.enumerated()), id: \.offset) { index, country in
                            Text(country.name).tag(index)
                        }
                    }
                }
            }
            .navigationBarTitle("Add Recipe")
            .navigationBarItems(trailing: saveButton.disabled(!viewModel.input.isSaveEnabled))
            .validation(viewModel.input.saveButtonValidation, flag: $viewModel.input.isSaveEnabled)
        }
    }
}

// MARK: - Private methods
private extension AddRecipeView {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

// MARK: - Subviews
private extension AddRecipeView {
    
    @ViewBuilder var saveButton: some View {
        Button(action: {
            viewModel.saveRecipeFromInput()
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Text("Save")
        })
    }
    
    @ViewBuilder
    var buttonImage: some View {
        let isPickedImage = viewModel.input.pickedImage != nil
        let image: Image = {
            if let pickedImage = viewModel.input.pickedImage {
                return Image(uiImage: pickedImage)
            } else {
                return Image(systemName: "plus.circle")
            }
        }()
        
        image
            .renderingMode(isPickedImage ? .original : .template)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .overlay(
                Circle()
                    .stroke(isPickedImage ? Color.systemTint : Color.clear, lineWidth: 3)
                    .shadow(radius: 10)
            )
            .foregroundColor(Style.buttonForegroundColor)
            .frame(width: isPickedImage ? UIScreen.Geometry.width / 2.0 - 12.0 : 96.0,
                   height: isPickedImage ? UIScreen.Geometry.width / 2.0 - 12.0 : 96.0,
                   alignment: .center)
    }
    
    @ViewBuilder
    func detailsTextView(text: Binding<String>) -> some View {
        if #available(iOS 14, *) {
            TextEditor(text: text)
        } else {
            TextView(text: text)
        }
    }
    
    struct Style {
        private static var colorScheme: UIUserInterfaceStyle { UITraitCollection.current.userInterfaceStyle}
        
        static var buttonForegroundColor: Color {
            switch colorScheme {
            case .light:
                return .secondary
            case .dark:
                return .secondary
            case .unspecified:
                return .primary
            @unknown default:
                return .primary
            }
        }
        
        static var buttonBackgroundColor: Color {
            switch colorScheme {
            case .light:
                return .black
            case .dark:
                return .white
            case .unspecified:
                return .white
            @unknown default:
                return .white
            }
        }
    }
}

struct AddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeView(viewModel: AddRecipeViewModel(recipeStorage: RecipeDataStorage()))
    }
}
