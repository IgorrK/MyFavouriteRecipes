//
//  AddRecipeView.swift
//  My Favourite Recipes
//
//  Created by Igor Kulik on 09.12.2021.
//

import SwiftUI
import ImagePicker
import Model

struct AddRecipeView: View {
    
    // MARK: - Properties
    
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var viewModel: AddRecipeViewModel
    
    @State private var recipeName: String = ""
    @State private var recipeDetails: String = ""
    @State private var ingredient: String = ""
    @State private var showsSourceType = false
    @State private var showsImagePicker = false
    @State private var showsPermissionDeniedAlert: Bool = false
    @State private var pickerSourceType: ImagePicker.SourceType = .photoLibrary
    @State private var pickedImage: UIImage?
    @State private var selectedCountry: Int?
    
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
                    ImagePicker.picker(sourceType: pickerSourceType, selectedImage: $pickedImage)
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
                
                Section(header: Text("Details")) {
                    detailsTextView(text: $recipeDetails)
                        .frame(height: 220)
                }
                
                Section(header: Text("Country of Origin:")) {
                    Picker(selection: $selectedCountry, label: Text("Country")) {
                        ForEach(Array(viewModel.countryListDataSource.enumerated()), id: \.offset) { index, country in
                            Text(country.name).tag(index as Int?)
                        }
                    }//.id(UUID())
                }
            }
            .navigationBarTitle("Add Recipe")
            .navigationBarItems(trailing: Button(action: {
                guard let countryIndex = selectedCountry else {
                    print("Country not selected")
                    return
                }
                
                let country = viewModel.countryListDataSource[countryIndex]

                viewModel.saveRecipe(name: recipeName,
                                     ingredients: viewModel.ingredients,
                                     recipe: recipeDetails,
                                     country: country,
                                     image: pickedImage)
                
                presentationMode.wrappedValue.dismiss()
                
            }) {
                Text("Save")
            }
            )
        }
    }
}

// MARK: - Subviews
private extension AddRecipeView {
    @ViewBuilder
    var buttonImage: some View {
        if let pickedImage = pickedImage {
            Image(uiImage: pickedImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .overlay(
                    Circle()
                        .stroke(Color.systemTint, lineWidth: 3)
                        .shadow(radius: 10)
                )
        } else {
            Image(systemName: "plus.circle")
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .foregroundColor(Style.buttonForegroundColor)
                .frame(width: 96.0, height: 96.0, alignment: .center)
        }
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
