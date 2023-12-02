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
    
    @Query private var categories: [Category]
    
    var body: some View {
        NavigationView {
            if let recipe {
                Form {
                    Section(header: Text("Title")) {
                        TextField("Title", text: Binding(get: { recipe.title }, set: { recipe.title = $0 }), axis: .vertical)
                        //                    TextEditor(text: Binding(get: { recipe.title }, set: { recipe.title = $0 }))
                    }
                    Section(header: Text("Author")) {
                        TextField("Author", text: Binding(get: { recipe.author }, set: { recipe.author = $0 }), axis: .vertical)
                    }
                    Section(header: Text("Date")) {
                        TextField("Date", text: Binding(get: { recipe.date }, set: { recipe.date = $0 }), axis: .vertical)
                    }
                    Section(header: Text("Time Required")) {
                        TextField("Time Required", text: Binding(get: { recipe.timeRequired }, set: { recipe.timeRequired = $0 }), axis: .vertical)
                    }
                    Section(header: Text("Servings")) {
                        TextField("Servings", text: Binding(get: { recipe.servings }, set: { recipe.servings = $0 }), axis: .vertical)
                    }
                    Section(header: Text("Expertise Required")) {
                        TextField("Expertise Required", text: Binding(get: { recipe.expertiseRequired }, set: { recipe.expertiseRequired = $0 }), axis: .vertical)
                    }
                    Section(header: Text("Calories Per Serving")) {
                        TextField("Calories Per Serving", text: Binding(get: { recipe.caloriesPerServing }, set: { recipe.caloriesPerServing = $0 }), axis: .vertical)
                    }
                    Section(header: Text("Ingredients")) {
                        TextField("Ingredients", text: Binding(get: { recipe.ingredients }, set: { recipe.ingredients = $0 }), axis: .vertical)
                    }
                    Section(header: Text("Instructions")) {
                        TextField("Instructions", text: Binding(get: { recipe.instructions }, set: { recipe.instructions = $0 }), axis: .vertical)
                    }
                    Section(header: Text("notes")) {
                        TextField("Notes", text: Binding(get: { recipe.notes }, set: { recipe.notes = $0 }), axis: .vertical)
                    }
                    Section(header: Text("Category")) {
                        Picker("Category", selection: Binding(get: { recipe.category }, set: { newValue in
                            recipe.category = newValue
                        })) {
                            ForEach(categories) { category in
                                Text(category.name).tag(category.name)
                            }
                        }
                    }
                }
                .toolbar {
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
}

struct EditRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: Recipe.self, configurations: config)
            let example = Recipe(title: "Example Destination", author: "John Doe", date: "11/29/2023", timeRequired: "3 hours", servings: "20", expertiseRequired: "Beginner", caloriesPerServing: "300", ingredients: "Example details go here and will automatically expand vertically as they are edited.", instructions: "Opa", notes: "cook on medium heat", category: "desserts", favorite: true)
            return EditRecipeView(recipe: example)
                .modelContainer(container)
        } catch {
            fatalError("Failed to create model container.")
        }
    }
}
