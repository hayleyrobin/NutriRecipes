//
//  IngredientsViewCell.swift
//  NutriRecipies
//
//  Created by Hayley Robinson on 12/1/21.
//

import UIKit

class IngredientsViewCell: UITableViewCell {
    
    @IBOutlet weak var ingredientLabel: UILabel!
    @IBOutlet weak var addIngredientButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    /*
    // MARK: - Helper Methods
    func configure(for result: RecommendationsResult) {
        let ingredients = result.recipe.ingredientLines
        
        ingredientLabel.text = ingredients[0]

    }
    // MARK: - Helper Methods
    func updateUI(for result: RecommendationsResult) {
        ingredientLabel.text = result.recipe.label
      
      if searchResult.artist.isEmpty {
        artistNameLabel.text = "Unknown"
      } else {
        artistNameLabel.text = searchResult.artist
      }
      
      kindLabel.text = searchResult.type
      genreLabel.text = searchResult.genre
    }
 */
}
