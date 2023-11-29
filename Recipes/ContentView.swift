//
//  ContentView.swift
//  Recipes
//
//  Created by Lehi Alcantara on 11/21/23.
//

import SwiftUI
import SwiftData
import MarkdownUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var recipes: [Recipe]
//    @State var isCreateModal: Bool = false
    
    var body: some View {
        NavigationSplitView {
            List {
                // A section of top-level abilities like browse all, search, favorites
                Section(header: Text("Top Level Actions")) {
                    NavigationLink {
                        browseAllList
                    } label: {
                        Text("Browse All")
                    }

                    NavigationLink {
                        Text("Search view")
                        // TODO: figure this out
                    } label: {
                        Text("Search")
                    }
                }

                // Categories
            }
        } content: {
            browseAllList
        } detail: {
            Text("Select an item")
        }
    }
    
    private var browseAllList: some View {
        List {
            ForEach(recipes) { recipe in
                NavigationLink {
                    ScrollView {
                        VStack {
                            Markdown {
                                recipe.title
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
                        }
                    }
                } label: {
                    Text(recipe.title)
                }
            }
            .onDelete(perform: deleteItems)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem {
                Button(action: initializeRecipes) {
                    Label("Initialize", systemImage: "folder.badge.plus")
                }
            }
            ToolbarItem {
                NavigationLink(destination: NewRecipeView()) {
                    Image(systemName: "plus").imageScale(.large)
                }
            }
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Recipe(title: "Some Item", ingredients: "Some Stuff", instructions: "Do something")
            modelContext.insert(newItem)
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(recipes[index])
            }
        }
    }
    
    private func initializeRecipes() {
        withAnimation {
            for recipe in sampleRecipes {
                modelContext.insert(recipe)
            }
            //            if let recipes = loadJson(filename: "SampleData") {
            //                for recipe in recipes {
            //                    modelContext.insert(Item(
            //                        title: recipe.title,
            //                        ingredients: recipe.ingredients,
            //                        instructions: recipe.instructions
            //                    ))
            //                }
            //            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Recipe.self, inMemory: true)
}
