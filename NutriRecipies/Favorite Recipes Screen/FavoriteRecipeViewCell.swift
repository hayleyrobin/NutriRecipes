//
//  FavoriteRecipeViewCell.swift
//  NutriRecipies
//
//  Created by Hayley Robinson on 12/4/21.
//

import UIKit

class FavoriteRecipeViewCell: UICollectionViewCell {
    @IBOutlet var recipeNameLabel: UILabel!
    @IBOutlet weak var mealTypeLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var recipeImg: UIImageView!
    var downloadTask: URLSessionDownloadTask?
    
    func configure(for result: RecommendationsResult){
        
        recipeNameLabel.text = result.recipe.label

        if ((result.recipe.label?.isEmpty) == nil) {
            recipeNameLabel.text = "Unknown"
        }
        
        mealTypeLabel.text = result.recipe.mealType.first as? String
        sourceLabel.text = result.recipe.source
        
        recipeImg.image = UIImage(systemName: "square")
        if let previewURL = URL(string: result.recipe.image!) {
          downloadTask = recipeImg.loadImage(url: previewURL)
        }

    }
    
    func configure(for result: TrendingResults){
        recipeNameLabel.text = result.recipe.label

        if ((result.recipe.label?.isEmpty) == nil) {
            recipeNameLabel.text = "Unknown"
        }
        
        mealTypeLabel.text = result.recipe.mealType.first
        sourceLabel.text = result.recipe.source
        
        recipeImg.image = UIImage(systemName: "square")
        if let previewURL = URL(string: result.recipe.image!) {
          downloadTask = recipeImg.loadImage(url: previewURL)
        }
    }
    
    
}
