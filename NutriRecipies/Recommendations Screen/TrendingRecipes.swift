//
//  TrendingRecipes.swift
//  NutriRecipies
//
//  Created by Hayley Robinson on 11/30/21.
//

import Foundation

struct TrendingRecipes: Codable{
    var from: Int
    var to: Int
    var count: Int
    var _links: [String: [String: String]]
    var hits = [TrendingResults]()
}
struct TrendingResults: Codable {
    var recipe: Recipe
   // let _links: [String: [String: String]]?
    
    struct Recipe: Codable, CustomStringConvertible
    {
        var description: String {
            return "\nResult - Name: \(label ?? "None"), Description: \(source ?? "None")"
        }
        var label: String?
        var source: String?
        var image: String?
        var url: String?
        var yield: Int?
        var dietLabels = [String]()
        var healthLabels = [String]()
        var ingredientLines = [String]()
        var calories: Double?
        var totalTime: Double?
        var cuisineType = [String]()
        var mealType = [String]()
        var dishType = [String]()
    }
}

extension TrendingRecipes {
    static func trendingRecipies() -> [TrendingResults]{
        guard
            let url = URL(string: "https://api.edamam.com/api/recipes/v2?type=public&q=Trending&app_id=6c3d1b83&app_key=76150e06464b0459d3ddb0985514e64a"),
            let data = try? Data(contentsOf: url)
        else {
            print("hello")
            return []
        }
        
        do {
            print("good")
          let decoder = JSONDecoder()
            let result = try decoder.decode(TrendingRecipes.self, from: data)
            return result.hits
        } catch {
          return []
        }
    }
}
