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
    
    var body: some View {
        if let recipe {
            ScrollView {
                VStack {
                    Markdown {
                        recipe.title
                    }
                    .padding()
                    Markdown {
                        recipe.author
                    }
                    .padding()
                    Markdown {
                        recipe.date
                    }
                    .padding()
                    Markdown {
                        recipe.timeRequired
                    }
                    .padding()
                    Markdown {
                        recipe.servings
                    }
                    .padding()
                    Markdown {
                        recipe.expertiseRequired
                    }
                    .padding()
                    Markdown {
                        recipe.caloriesPerServing
                    }
                    .padding()
                    Markdown {
                        recipe.ingredients
                    }
                    .padding()
                    Markdown {
                        recipe.instructions
                    }
                    .padding()
                    Markdown {
                        recipe.notes
                    }
                    .padding()
                    Markdown {
                        recipe.category
                    }
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
                    NavigationLink(destination: EditRecipeView(recipe: recipe)) {
                        Image(systemName: "pencil").imageScale(.large)
                    }
                }
            }
        }
    }
}



struct RecipeDetailView_Previews: PreviewProvider {
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
