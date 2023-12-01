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
    
    var body: some View {
        NavigationView {
            if let recipe {
                Form {
                    Section(header: Text("Title")) {
                        TextField("Title", text: Binding(get: { recipe.title }, set: { recipe.title = $0 }), axis: .vertical)
                        //                    TextEditor(text: Binding(get: { recipe.title }, set: { recipe.title = $0 }))
                    }
                    //            TextField("Author", text: $recipe.author)
                    //            TextField("Date", text: $recipe.date)
                    //            TextField("Time Required", text: $recipe.timeRequired)
                    //            TextField("Servings", text: $recipe.servings)
                    //            TextField("Expertise Required", text: $recipe.expertiseRequired)
                    //            TextField("Calories Per Serving", text: $recipe.caloriesPerServing)
                    Section(header: Text("Ingredients")) {
                        TextField("Ingredients", text: Binding(get: { recipe.ingredients }, set: { recipe.ingredients = $0 }), axis: .vertical)
                    }
                    Section(header: Text("Instructions")) {
                        TextField("Instructions", text: Binding(get: { recipe.instructions }, set: { recipe.instructions = $0 }), axis: .vertical)
                    }
                    //            TextEditor(text: $recipe.notes)
                    //            Picker("Category", selection: $recipe.category) {
                    //                Text("").tag("")
                    //                Text("Pork").tag("pork")
                    //                Text("Chicken").tag("chicken")
                    //                Text("Steak").tag("steak")
                    //            }
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
            let example = Recipe(title: "Example Destination", ingredients: "Example details go here and will automatically expand vertically as they are edited.", instructions: "Opa", favorite: true)
            return EditRecipeView(recipe: example)
                .modelContainer(container)
        } catch {
            fatalError("Failed to create model container.")
        }
    }
}
