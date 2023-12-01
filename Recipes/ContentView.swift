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
    @Query private var categories: [Category]
    @State private var selectedRecipe: Recipe?
    @State private var selectedCategory: Category?
    
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
                Section(header: Text("Categories")) {
                    NavigationLink {
                        categoriesList
                    } label: {
                        Text("Categories")
                    }
                }
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
                } label: {
                    Text(recipe.title)
                }
                .onTapGesture {
                    selectedRecipe = recipe
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
    
    private var categoriesList: some View {
        List {
            ForEach(categories) { category in
                NavigationLink {
                    ScrollView {
                        VStack {
                            Markdown {
                                category.name
                            }
                            .padding()
                        }
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            NavigationLink(destination: EditCategoryView(category: category)) {
                                Image(systemName: "pencil").imageScale(.large)
                            }
                        }
                    }
                } label: {
                    Text(category.name)
                }
                .onTapGesture {
                    selectedCategory = category
                }
            }
            .onDelete(perform: deleteCategory)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem {
                Button(action: initializeCategories) {
                    Label("Initialize", systemImage: "folder.badge.plus")
                }
            }
            ToolbarItem {
                NavigationLink(destination: NewCategoryView()) {
                    Image(systemName: "plus").imageScale(.large)
                }
            }
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Recipe(title: "Some Item", ingredients: "Some Stuff", instructions: "Do something", favorite: false)
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
    
    private func deleteCategory(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(categories[index])
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
    
    private func initializeCategories() {
        withAnimation {
            for category in sampleCategories {
                modelContext.insert(category)
            }
            //            if let categories = loadJson(filename: "SampleCategoryData") {
            //                for category in categories {
            //                    modelContext.insert(Category(
            //                        name: category.name
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
