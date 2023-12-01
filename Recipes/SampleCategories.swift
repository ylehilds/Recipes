//
//  SampleCategories.swift
//  Recipes
//
//  Created by Lehi Alcantara on 11/30/23.
//

import Foundation

// See https://stackoverflow.com/a/36827996

struct ResponseCategoryData: Decodable {
    var categories: [SampleCategory]
}
struct SampleCategory : Decodable {
    var name: String
}

func loadJson(filename fileName: String) -> [SampleCategory]? {
    if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
        do {
            let data = try Data(contentsOf: url)
            let jsonData = try JSONDecoder().decode(ResponseCategoryData.self, from: data)
            return jsonData.categories
        } catch {
            print("error: \(error)")
        }
    }
    return nil
}

let sampleCategories = [
    Category( name: "main dish" ),
    Category( name: "side dish" ),
    Category( name: "desserts" ),
    Category( name: "breads" ),
    Category( name: "healthy" ),
    Category( name: "fusion" ),
    Category( name: "comfort" ),
    Category( name: "lunch" ),
    Category( name: "dinner" ),
    Category( name: "breakfast" ),
    Category( name: "quick" ),
    Category( name: "gourmet" ),
    Category( name: "smoothies" ),
    Category( name: "snacks" )
]
