//
//  Recipe.swift
//  Recipes
//
//  Created by Lehi Alcantara on 11/21/23.
//

import Foundation
import SwiftData

@Model
final class Recipe {
    var title: String
    var ingredients: String
    var instructions: String
    var favorite: Bool
    var category: String?
    
    init(title: String, ingredients: String, instructions: String, favorite: Bool, category: String? = nil) {
        self.title = title
        self.ingredients = ingredients
        self.instructions = instructions
        self.favorite = favorite
        self.category = category
    }
}

@Model
final class Category {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}
