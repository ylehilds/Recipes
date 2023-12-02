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
    @State private var showAlert = false

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
                    if name.isEmpty {
                        showAlert = true
                    } else {
                        addCategory()
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error"), message: Text("Category name is required"), dismissButton: .default(Text("OK")))
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
