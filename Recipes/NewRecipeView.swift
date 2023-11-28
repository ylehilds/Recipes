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
            Section {
                TextField("Title", text: $title)
            }
            Section {
                TextField("Author", text: $author)
            }
            Section {
                TextField("Date", text: $date)
            }
            Section {
                TextField("Time Required", text: $timeRequired)
            }
            Section {
                TextField("Servings", text: $servings)
            }
            Section {
                TextField("Expertise Required", text: $expertiseRequired)
            }
            Section {
                TextField("Calories Per Serving", text: $caloriesPerServing)
            }
            Section {
                TextField("Ingredients", text: $ingredients)
            }
            Section {
                TextField("Instructions", text: $instructions)
            }
            Section {
                TextField("Notes", text: $notes)
            }
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
            let newItem = Item(title: title, ingredients: ingredients, instructions: instructions)
            modelContext.insert(newItem)
        }
    }
}

#Preview {
    NewRecipeView()
}