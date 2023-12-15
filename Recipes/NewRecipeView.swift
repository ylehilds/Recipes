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
    @Environment(\.dismiss) private var dismiss
    @State private var showAlert = false
    @Query private var categories: [Category]
    @State private var selectedCategories: [Category] = []
    
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
//    @State private var category:[Category] = []
    
    var body: some View {
        VStack {
            HStack {
                Button("Cancel") {
                    dismiss()
                }
                Spacer()
                
                Text("New Recipe").font(.headline)
                Spacer()
                
                Button("Save") {
                    if selectedCategories.isEmpty || title.isEmpty || author.isEmpty || date.isEmpty || timeRequired.isEmpty || servings.isEmpty || expertiseRequired.isEmpty || caloriesPerServing.isEmpty || ingredients.isEmpty || instructions.isEmpty {
                        showAlert = true
                    } else {
                        do {
                            addItem()
                            try modelContext.save()
                            dismiss()
                        } catch {
                            print("An error occurred: \(error)")
                        }
                    }
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error"), message: Text("All text fields are required"), dismissButton: .default(Text("OK")))
                }
            }
            .padding()
            Form {
                TextField("Title", text: $title, axis: .vertical)
                TextField("Author", text: $author, axis: .vertical)
                TextField("Date", text: $date, axis: .vertical)
                TextField("Time Required", text: $timeRequired, axis: .vertical)
                TextField("Servings", text: $servings, axis: .vertical)
                TextField("Expertise Required", text: $expertiseRequired, axis: .vertical)
                TextField("Calories Per Serving", text: $caloriesPerServing, axis: .vertical)
                TextField("Ingredients", text: $ingredients, axis: .vertical)
                TextField("Instructions", text: $instructions, axis: .vertical)
                TextField("Notes", text: $notes, axis: .vertical)
                // When the picker only accepted 1 value
                //                Picker("Category", selection: $category) {
                //                    Text("").tag("")
                //                    ForEach(categories) { category in
                //                        Text(category.name).tag(category.name)
                //                    }
                //                }
                List {
                    ForEach(categories, id: \.self) { category in
                        Toggle(category.name, isOn: Binding(
                            get: { self.selectedCategories.contains(category) },
                            set: { (newValue) in
                                if newValue {
                                    self.selectedCategories.append(category)
                                } else {
                                    self.selectedCategories.removeAll { $0 == category }
                                }
                            }
                        ))
                    }
                }
                Text("Selected Categories: \(selectedCategories.map { $0.name }.joined(separator: ", "))")
            }
        }
    }
    
    private func addItem() {
        withAnimation {
            do {
                let recipe = Recipe(title: title, author: author, date: date, timeRequired: timeRequired, servings: servings, expertiseRequired: expertiseRequired, caloriesPerServing: caloriesPerServing, ingredients: ingredients, instructions: instructions, notes: notes, categories: selectedCategories, favorite: false)
                try modelContext.insert(recipe)
                dismiss()
            } catch {
                print("An error occurred: \(error)")
            }
            
            //            modelContext.insert(recipe)
        }
    }
}

#Preview {
    NewRecipeView()
}
