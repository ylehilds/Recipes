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
        VStack {
            HStack {
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
                Spacer()
                
                Text("New Category").font(.headline)
                Spacer()
                
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
            .padding()
            Form {
                TextField("Name", text: $name)
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
