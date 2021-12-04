//
//  detailHeaderCell.swift
//  NutriRecipies
//
//  Created by Hayley Robinson on 12/1/21.
//

import UIKit

class RecipeHeaderCell: UITableViewCell {

    @IBOutlet weak var recipeImg: UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var cookTimeLabel: UILabel!
    @IBOutlet weak var servingsLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var mealTypeLabel: UILabel!
    @IBOutlet weak var recipeView: UIView!
    var downloadTask: URLSessionDownloadTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    // MARK: - Helper Methods
    func configure(for result: RecommendationsResult) {
        //round border for recipe view
        recipeView.layer.cornerRadius = 10
        recipeView.clipsToBounds = true

        recipeView.layer.borderColor = UIColor.white.cgColor
        recipeView.layer.borderWidth = 2.0
        
        // bold recipe title
        recipeNameLabel.font = UIFont.boldSystemFont(ofSize: recipeNameLabel.font.pointSize)

        recipeNameLabel.text = result.recipe.label

        if ((result.recipe.label?.isEmpty) == nil) {
            recipeNameLabel.text = "Unknown"
        }
        
        cookTimeLabel.text = String(format:"%d", result.recipe.totalTime!) + " min"
        servingsLabel.text = String(format: "%i", result.recipe.yield!) + " servings"
        caloriesLabel.text = String(format:"%d", result.recipe.calories!) + " calories"
        mealTypeLabel.text = result.recipe.mealType.first as? String
 
        recipeImg.image = UIImage(systemName: "square")
        if let previewURL = URL(string: result.recipe.image!) {
          downloadTask = recipeImg.loadImage(url: previewURL)
        }
    }
    func configure(for result: TrendingResults) {
        // round border for recipe view
        recipeView.layer.cornerRadius = 10
        recipeView.clipsToBounds = true

        recipeView.layer.borderColor = UIColor.white.cgColor
        recipeView.layer.borderWidth = 2.0
        
        // bold recipe title
        recipeNameLabel.font = UIFont.boldSystemFont(ofSize: recipeNameLabel.font.pointSize)

        recipeNameLabel.text = result.recipe.label

        if ((result.recipe.label?.isEmpty) == nil) {
            recipeNameLabel.text = "Unknown"
        }
        
        cookTimeLabel.text = String(format:"%d", result.recipe.totalTime!) + " min"
        servingsLabel.text = String(format: "%i", result.recipe.yield!) + " servings"
        caloriesLabel.text = String(format:"%d", result.recipe.calories!) + " calories"
        mealTypeLabel.text = result.recipe.mealType.first
 
        recipeImg.image = UIImage(systemName: "square")
        if let previewURL = URL(string: result.recipe.image!) {
          downloadTask = recipeImg.loadImage(url: previewURL)
        }
    }

}
