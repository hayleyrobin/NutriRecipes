//
//  RecommendedCollectionViewCell.swift
//  NutriRecipies
//
//  Created by Hayley Robinson on 12/10/21.

/*  Collection View Cell Source:  https://johncodeos.com/how-to-add-uicollectionview-inside-uitableviewcell-using-swift/
    Rounded Cell: https://www.advancedswift.com/uicollectionviewcell-rounded-corners-and-shadow-swift/
*/

import UIKit

class RecommendedCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var recipeImg: UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var mealTypeLabel: UILabel!
    
    var downloadTask: URLSessionDownloadTask?
    
    override func awakeFromNib() {
            super.awakeFromNib()
        // Apply rounded corners
        contentView.layer.cornerRadius = 5.0
        contentView.layer.masksToBounds = true
                
        // Set masks to bounds to false to avoid the shadow
        // from being clipped to the corner radius
        layer.cornerRadius = 5.0
        layer.masksToBounds = false
    }

    
    func configure(for result: RecommendationResults){
        
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
}
