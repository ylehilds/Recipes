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
    @Query(sort: [SortDescriptor(\Recipe.title)]) private var recipes: [Recipe]
    
    @Query(sort: [SortDescriptor(\Category.name)]) private var categories: [Category]
    @State private var search = ""
    @State private var showingCreateRecipeSheet = false
    @State private var showingCreateCategorySheet = false
    
    var body: some View {
        NavigationSplitView {
            List {
                // A section of top-level abilities like browse all, search, favorites
                Section(header: Text("Recipes")) {
                    NavigationLink {
                        browseAllList(recipes: recipes)
                    } label: {
                        Text("Browse By Title")
                    }
                    NavigationLink {
                        browseFavoritesList(recipes: recipes.filter { $0.favorite })
                    } label: {
                        Text("Browse By Favorites")
                    }
                    
                    NavigationLink(destination: recipeSearch) {
                        Text("Recipe Search")
                    }
                }
                
                Section(header: Text("Recipes by Categories")) {
                    ForEach(categories) { category in
                        NavigationLink(destination: browseAllList(recipes: recipes.filter { $0.category == category.name })) {
                            ScrollView {
                                VStack {
                                    Markdown {
                                        category.name
                                    }
                                }
                            }
                        }
                    }
                }
                
                // Categories
                Section(header: Text("Categories")) {
                    NavigationLink {
                        categoriesList
                    } label: {
                        Text("Categories Editor")
                    }
                }
            }
        } content: {
            Text("select a menu item")
        } detail: {
            NavigationStack {
                Text("select a recipe")
            }
        }
        .onAppear {
            let defaults = UserDefaults.standard
            if !defaults.bool(forKey: "dataLoaded") {
                if recipes.isEmpty {
                    initializeRecipes()
                }
                
                if categories.isEmpty {
                    initializeCategories()
                }
                
                defaults.set(true, forKey: "dataLoaded")
            }
        }
    }
    
    private func browseAllList(recipes: [Recipe]) -> some View {
        List {
            if recipes.count == 0 {
                Text("No recipes yet. Tap the + button to add a recipe.")
            } else {
                ForEach(recipes) { recipe in
                    NavigationLink(recipe.title) { RecipeDetailView(recipe: recipe) }
                }
                .onDelete(perform: deleteItems)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            //            ToolbarItem {
            //                Button(action: initializeRecipes) {
            //                    Label("Initialize", systemImage: "folder.badge.plus")
            //                }
            //            }
            ToolbarItem {
                Button(action: {
                    showingCreateRecipeSheet.toggle()
                }) {
                    Image(systemName: "plus").imageScale(.large)
                }
                .sheet(isPresented: $showingCreateRecipeSheet) {
                    NewRecipeView()
                }
            }
        }
    }
    
    private func browseFavoritesList(recipes: [Recipe]) -> some View {
        List {
            ForEach(recipes) { recipe in
                NavigationLink {
                    RecipeDetailView(recipe: recipe)
                } label: {
                    Text(recipe.title)
                }
            }
            .onDelete(perform: deleteItems)
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
                }
            label: {
                Text(category.name)
            }
            }
            .onDelete(perform: deleteCategory)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            //            ToolbarItem {
            //                Button(action: initializeCategories) {
            //                    Label("Initialize", systemImage: "folder.badge.plus")
            //                }
            //            }
            ToolbarItem {
                Button(action: {
                    showingCreateCategorySheet.toggle()
                }) {
                    Image(systemName: "plus").imageScale(.large)
                }
                .sheet(isPresented: $showingCreateCategorySheet) {
                    NewCategoryView()
                }
            }
        }
    }
    
    private var recipeSearch: some View {
        VStack {
            Form {
                TextField("Search", text: $search)
            }
            if search.isEmpty {
                Text("Enter a search term (title, ingredients, or notes)")
            }
            List {
                ForEach(recipes.filter { $0.title.lowercased().contains(search.lowercased()) || $0.ingredients.lowercased().contains(search.lowercased()) || $0.notes.lowercased().contains(search.lowercased()) }) { recipe in
                    NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                        ScrollView {
                            VStack {
                                Markdown {
                                    recipe.title
                                }
                            }
                        }
                    }
                }
            }
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
        .modelContainer(for: [Recipe.self, Category.self], inMemory: true)
}
