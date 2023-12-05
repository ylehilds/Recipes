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
    @State private var showAlert = false
    
    func formIsValid(_ category: Category) -> Bool {
        !category.name.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                if let category {
                    Form {
                        Section(header: Text("Category")) {
                            TextField("Category", text: Binding(get: { category.name }, set: { newValue in
                                category.name = newValue
                                showAlert = !formIsValid(category)
                            }), axis: .vertical)
                            // TextEditor(text: Binding(get: { category.name }, set: { category.name = $0 }))
                        }
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: {
                                if formIsValid(category) {
                                    presentationMode.wrappedValue.dismiss()
                                } else {
                                    showAlert = true
                                }
                            }) {
                                Image(systemName: "arrow.backward")
                                Text("Back")
                            }
                            .disabled(!formIsValid(category))
                            .alert(isPresented: $showAlert) {
                                Alert(title: Text("Error"), message: Text("Category name is required"), dismissButton: .default(Text("OK")))
                            }
                        }
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
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    EditCategoryView()
}

struct EditCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        do {
            let schema = Schema([
                Recipe.self,
                Category.self
            ])
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
            let example = Category(name: "Desserts")
            return EditCategoryView(category: example)
                .modelContainer(container)
        } catch {
            fatalError("Failed to create model container.")
        }
    }
}
