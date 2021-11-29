//
//  RecommendationsResult.swift
//  NutriRecipies
//
//  Created by Hayley Robinson on 11/20/21.
//

import Foundation

struct ResultArray: Codable {
    var from: Int
    var to: Int
    var count: Int
    var _links: [String: [String: String]]
    var hits = [RecommendationsResult]()
}

struct RecommendationsResult: Codable {
    var recipe: Recipe
   // let _links: [String: [String: String]]?
    
    struct Recipe: Codable, CustomStringConvertible
    {
        var description: String {
            return "\nResult - Name: \(label ?? "None"), Description: \(source ?? "None")"
        }
        var label: String?
        var source: String?
        var url: String?
        var yield: Int?
        var dietLabels = [String]()
        var healthLabels = [String]()
        var ingredientLines = [String]()
        var calories: Double?
        var cuisineType = [String]()
        var mealType = [String]()
        var dishType = [String]()
        
        

    }

}

