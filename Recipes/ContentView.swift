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
    @Query private var items: [Item]
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        ScrollView {
                            VStack {
                                Markdown {
                                    item.title
                                }
                                .padding()
                                Markdown {
                                    item.ingredients
                                }
                                .padding()
                                Markdown {
                                    item.instructions
                                }
                                .padding()
                            }
                        }
                    } label: {
                        Text(item.title)
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
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(title: "Some Item", ingredients: "Some Stuff", instructions: "Do something")
            modelContext.insert(newItem)
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
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
        .modelContainer(for: Item.self, inMemory: true)
}
