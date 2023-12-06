//
//  RecipeDetailView.swift
//  Recipes
//
//  Created by Lehi Alcantara on 12/1/23.
//

import SwiftUI
import SwiftData
import MarkdownUI

struct RecipeDetailView: View {
    let recipe: Recipe?
    
    var shareContent: String {
                        guard let recipe = recipe else { return "" }
                        return """
                        ## \(recipe.title)
                        **Author:** \(recipe.author)
                        **Date:** \(recipe.date)
                        **Time Required:** \(recipe.timeRequired)
                        **Servings:** \(recipe.servings)
                        **Expertise Required**: \(recipe.expertiseRequired)
                        **Calories Per Serving**: \(recipe.caloriesPerServing)
                        \(recipe.ingredients)
                        \(recipe.instructions)
                        \(recipe.notes)
                        **Category**: \(recipe.category)
                        """
                    }
    
    var body: some View {
        //        NavigationStack {
        //            ZStack {
        if let recipe = recipe {
            ScrollView {
                VStack {
                    Markdown ("## \(recipe.title)")
                        .padding()
                    Markdown ("**Author:** \(recipe.author)")
                        .padding()
                    Markdown ("**Date:** \(recipe.date)")
                        .padding()
                    Markdown ("**Time Required:** \(recipe.timeRequired)")
                        .padding()
                    Markdown ("**Servings:** \(recipe.servings)")
                        .padding()
                    Markdown ("**Expertise Required**: \(recipe.expertiseRequired)")
                        .padding()
                    Markdown ("**Calories Per Serving**: \(recipe.caloriesPerServing)")
                        .padding()
                    Markdown ("\(recipe.ingredients)")
                        .padding()
                    Markdown ("\(recipe.instructions)")
                        .padding()
                    Markdown ("\(recipe.notes)")
                        .padding()
                    Markdown ("**Category**: \(recipe.category)")
                        .padding()
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: recipe.favorite ? "heart.fill" : "heart").imageScale(.large)
                        .foregroundColor(recipe.favorite ? .red : .gray)
                        .onTapGesture {
                            recipe.favorite.toggle()
                        }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationStack {
                        ZStack {
                            NavigationLink(destination: EditRecipeView(recipe: recipe)) {
                                Image(systemName: "pencil").imageScale(.large)
                            }
                        }
                        .navigationDestination(for: String.self) { text in
                            Text(verbatim: text)
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    ShareLink(item: shareContent)
                }
            }
        }
        else {
            Text("Select a Recipe!")
        }
    }
    //        }
    //    }
}

#Preview {
    let recipe = Recipe(title: "Feijoada", author: "John Doe", date: "11/29/2023", timeRequired: "3 hours", servings: "20", expertiseRequired: "Beginner", caloriesPerServing: "300", ingredients: "beans, pork, onions, etc...", instructions: "Cook for 2.5 hrs", notes: "cook on medium heat", category: "Comfort", favorite: true)
    return RecipeDetailView(recipe: recipe)
}
