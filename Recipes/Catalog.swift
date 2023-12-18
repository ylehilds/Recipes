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
    var author: String
    var date: String
    var timeRequired: String
    var servings: String
    var expertiseRequired: String
    var caloriesPerServing: String
    var ingredients: String
    var instructions: String
    var notes: String
    var category: [Category]
    var favorite: Bool
    
    init(title: String, author: String, date: String, timeRequired: String, servings: String, expertiseRequired: String, caloriesPerServing: String, ingredients: String, instructions: String, notes: String, category: [Category], favorite: Bool) {
        self.title = title
        self.author = author
        self.date = date
        self.timeRequired = timeRequired
        self.servings = servings
        self.expertiseRequired = expertiseRequired
        self.caloriesPerServing = caloriesPerServing
        self.ingredients = ingredients
        self.instructions = instructions
        self.notes = notes
        self.category = category
        self.favorite = favorite
    }
}

@Model
final class Category {
    @Attribute(.unique) var name: String
    
    @Relationship(inverse: \Recipe.category)
    var recipes = [Recipe]()
    
    init(name: String) {
        self.name = name
    }
}
