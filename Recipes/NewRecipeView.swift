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
    @Query private var categories: [Category]
    @State private var showAlert = false
    
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
        VStack {
            HStack {
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
                Spacer()
                
                Text("New Recipe").font(.headline)
                Spacer()
                
                Button("Save") {
                    if category.isEmpty || title.isEmpty || author.isEmpty || date.isEmpty || timeRequired.isEmpty || servings.isEmpty || expertiseRequired.isEmpty || caloriesPerServing.isEmpty || ingredients.isEmpty || instructions.isEmpty {
                        showAlert = true
                    } else {
                        addItem()
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error"), message: Text("All text fields are required"), dismissButton: .default(Text("OK")))
                }
            }
            .padding()
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
                    ForEach(categories) { category in
                        Text(category.name).tag(category.name)
                    }
                }
            }
        }
    }
    
    private func addItem() {
        withAnimation {
            let recipe = Recipe(title: title, author: author, date: date, timeRequired: timeRequired, servings: servings, expertiseRequired: expertiseRequired, caloriesPerServing: caloriesPerServing, ingredients: ingredients, instructions: instructions, notes: notes, category: category, favorite: false)
            modelContext.insert(recipe)
        }
    }
}

#Preview {
    NewRecipeView()
}
