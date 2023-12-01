//
//  NewCategoryView.swift
//  Recipes
//
//  Created by Lehi Alcantara on 11/30/23.
//

import SwiftUI
import SwiftData

struct NewCategoryView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode
    @State private var name = ""

    var body: some View {
        Form {
            TextField("Name", text: $name)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
            }
            ToolbarItem(placement: ToolbarItemPlacement.principal) {
                Text("New Category")
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    // Save the new recipe here
                    // For example, you might save it to your app's data store
                    addCategory()
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
    
    private func addCategory() {
        withAnimation {
            let newCategory = Category(name: name)
            modelContext.insert(newCategory)
        }
    }
}

#Preview {
    NewCategoryView()
}
