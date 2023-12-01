//
//  EditCategoryView.swift
//  Recipes
//
//  Created by Lehi Alcantara on 11/30/23.
//

import SwiftUI
import SwiftData

struct EditCategoryView: View {
    var category: Category?
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            if let category {
                Form {
                    Section(header: Text("Category")) {
                        TextField("Category", text: Binding(get: { category.name }, set: { category.name = $0 }), axis: .vertical)
                        // TextEditor(text: Binding(get: { category.name }, set: { category.name = $0 }))
                    }
                }
                .toolbar {
                    ToolbarItem(placement: ToolbarItemPlacement.principal) {
                        Text("Edit Category")
                    }
                }
            }
            else {
                Text("No Category Selected")
            }
        }
    }
}

#Preview {
    EditCategoryView()
}

struct EditCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: Category.self, configurations: config)
            let example = Category(name: "main dishes")
            return EditCategoryView(category: example)
                .modelContainer(container)
        } catch {
            fatalError("Failed to create model container.")
        }
    }
}
