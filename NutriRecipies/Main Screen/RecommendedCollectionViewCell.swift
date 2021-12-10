//
//  RecommendedCollectionViewCell.swift
//  NutriRecipies
//
//  Created by Hayley Robinson on 12/10/21.
//

import UIKit

class RecommendedCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var recipeImg: UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var mealTypeLabel: UILabel!
    
    var downloadTask: URLSessionDownloadTask?
    
    func configure(for result: RecommendationResults){
        
        recipeNameLabel.text = result.recipe.label

        if ((result.recipe.label?.isEmpty) == nil) {
            recipeNameLabel.text = "Unknown"
        }
        print("hello")
        mealTypeLabel.text = result.recipe.mealType.first as? String
        sourceLabel.text = result.recipe.source
        
        recipeImg.image = UIImage(systemName: "square")
        if let previewURL = URL(string: result.recipe.image!) {
          downloadTask = recipeImg.loadImage(url: previewURL)
        }

    }
    
}
