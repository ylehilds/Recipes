//
//  newRecipeView.swift
//  Recipes
//
//  Created by Lehi Alcantara on 11/27/23.
//

import SwiftUI
import SwiftData

struct NewRecipeView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode
    @State private var title = ""
    @State private var author = ""
    @State private var date = ""
    @State private var timeRequired = ""
    @State private var servings = ""
    @State private var expertiseRequired = ""
    @State private var caloriesPerServing = ""
    @State private var ingredients = ""
    @State private var instructions = ""
    @State private var notes = ""
    @State private var category = ""
    
    var body: some View {
        Form {
            TextField("Title", text: $title)
            TextField("Author", text: $author)
            TextField("Date", text: $date)
            TextField("Time Required", text: $timeRequired)
            TextField("Servings", text: $servings)
            TextField("Expertise Required", text: $expertiseRequired)
            TextField("Calories Per Serving", text: $caloriesPerServing)
            TextField("Ingredients", text: $ingredients, axis: .vertical)
            TextField("Instructions", text: $instructions, axis: .vertical)
            TextField("Notes", text: $notes, axis: .vertical)
            Picker("Category", selection: $category) {
                Text("").tag("")
                Text("Pork").tag("pork")
                Text("Chicken").tag("chicken")
                Text("Steak").tag("steak")
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
            }
            ToolbarItem(placement: ToolbarItemPlacement.principal) {
                Text("New Recipe")
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    // Save the new recipe here
                    // For example, you might save it to your app's data store
                    addItem()
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Recipe(title: title, ingredients: ingredients, instructions: instructions, favorite: false)
            modelContext.insert(newItem)
        }
    }
}

#Preview {
    NewRecipeView()
}
