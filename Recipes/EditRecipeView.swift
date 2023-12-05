//
//  EditRecipeView.swift
//  Recipes
//
//  Created by Lehi Alcantara on 11/29/23.
//

import SwiftUI
import SwiftData

struct EditRecipeView: View {
    var recipe: Recipe?
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode
    @State private var showAlert = false
    
    @Query private var categories: [Category]
    
    func formIsValid(_ recipe: Recipe) -> Bool {
        !recipe.category.isEmpty && !recipe.title.isEmpty && !recipe.author.isEmpty && !recipe.date.isEmpty && !recipe.timeRequired.isEmpty && !recipe.servings.isEmpty && !recipe.expertiseRequired.isEmpty && !recipe.caloriesPerServing.isEmpty && !recipe.ingredients.isEmpty && !recipe.instructions.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
//                NavigationView {
                    if let recipe {
                        Form {
                            Section(header: Text("Title")) {
                                TextField("Title", text: Binding(get: { recipe.title }, set: { newValue in
                                    recipe.title = newValue
                                    showAlert = !formIsValid(recipe)
                                }), axis: .vertical)
                            }
                            Section(header: Text("Author")) {
                                TextField("Author", text: Binding(get: { recipe.author }, set: { newValue in
                                    recipe.author = newValue
                                    showAlert = !formIsValid(recipe)
                                }), axis: .vertical)
                            }
                            Section(header: Text("Date")) {
                                TextField("Date", text: Binding(get: { recipe.date }, set: { newValue in
                                    recipe.date = newValue
                                    showAlert = !formIsValid(recipe)
                                }), axis: .vertical)
                            }
                            Section(header: Text("Time Required")) {
                                TextField("Time Required", text: Binding(get: { recipe.timeRequired }, set: { newValue in
                                    recipe.timeRequired = newValue
                                    showAlert = !formIsValid(recipe)
                                }), axis: .vertical)
                            }
                            Section(header: Text("Servings")) {
                                TextField("Servings", text: Binding(get: { recipe.servings }, set: { newValue in
                                    recipe.servings = newValue
                                    showAlert = !formIsValid(recipe)
                                }), axis: .vertical)
                            }
                            Section(header: Text("Expertise Required")) {
                                TextField("Expertise Required", text: Binding(get: { recipe.expertiseRequired }, set: { newValue in
                                    recipe.expertiseRequired = newValue
                                    showAlert = !formIsValid(recipe)
                                }), axis: .vertical)
                            }
                            Section(header: Text("Calories Per Serving")) {
                                TextField("Calories Per Serving", text: Binding(get: { recipe.caloriesPerServing }, set: { newValue in
                                    recipe.caloriesPerServing = newValue
                                    showAlert = !formIsValid(recipe)
                                }), axis: .vertical)
                            }
                            Section(header: Text("Ingredients")) {
                                TextField("Ingredients", text: Binding(get: { recipe.ingredients }, set: { newValue in
                                    recipe.ingredients = newValue
                                    showAlert = !formIsValid(recipe)
                                }), axis: .vertical)
                            }
                            Section(header: Text("Instructions")) {
                                TextField("Instructions", text: Binding(get: { recipe.instructions }, set: { newValue in
                                    recipe.instructions = newValue
                                    showAlert = !formIsValid(recipe)
                                }), axis: .vertical)
                            }
                            Section(header: Text("notes")) {
                                TextField("Notes", text: Binding(get: { recipe.notes }, set: { recipe.notes = $0 }), axis: .vertical)
                            }
                            Section(header: Text("Category")) {
                                Picker("Category", selection: Binding(get: { recipe.category }, set: { newValue in
                                    recipe.category = newValue
                                    showAlert = !formIsValid(recipe)
                                })) {
                                    ForEach(categories) { category in
                                        Text(category.name).tag(category.name)
                                    }
                                }
                            }
                        }
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button(action: {
                                    if formIsValid(recipe) {
                                        presentationMode.wrappedValue.dismiss()
                                    } else {
                                        showAlert = true
                                    }
                                }) {
                                    Image(systemName: "arrow.backward")
                                    Text("Back")
                                }
                                .disabled(!formIsValid(recipe))
                                .alert(isPresented: $showAlert) {
                                    Alert(title: Text("Error"), message: Text("All fields are required"), dismissButton: .default(Text("OK")))
                                }
                            }
                            ToolbarItem(placement: ToolbarItemPlacement.principal) {
                                Text("Edit Recipe")
                            }
                        }
                    }
                    else {
                        Text("No Recipe Selected")
                    }
                }
            }
//        }
                .navigationBarBackButtonHidden(true)
    }
}

struct EditRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        do {
            let schema = Schema([
                Recipe.self,
                Category.self
            ])
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
            let example = Recipe(title: "Example Destination", author: "John Doe", date: "11/29/2023", timeRequired: "3 hours", servings: "20", expertiseRequired: "Beginner", caloriesPerServing: "300", ingredients: "Example details go here and will automatically expand vertically as they are edited.", instructions: "Opa", notes: "cook on medium heat", category: "desserts", favorite: true)
            return EditRecipeView(recipe: example)
                .modelContainer(container)
        } catch {
            fatalError("Failed to create model container.")
        }
    }
}
