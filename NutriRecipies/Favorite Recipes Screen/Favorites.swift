//
//  Favorites.swift
//  NutriRecipies
//
//  Created by Hayley Robinson on 12/7/21.
//

import Foundation

class FavoriteRecipe{
    var label: String?
    var source: String?
    var image: String?
    var url: String?
    var yield: Int?
    var dietLabels = [String?]()
    var healthLabels = [String?]()
    var ingredientLines = [String?]()
    var calories: Double?
    var totalTime: Double?
    var cuisineType = [String?]()
    var mealType = [String?]()
    var dishType = [String?]()
    var favorited = false
}
