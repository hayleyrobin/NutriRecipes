//
//  NutritionViewCell.swift
//  NutriRecipies
//
//  Created by Hayley Robinson on 12/5/21.
//

import UIKit

class NutritionViewCell: UITableViewCell {
    @IBOutlet var dishTypeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func configure(for result: RecommendationsResult) {
        if result.recipe.dishType.isEmpty{
            dishTypeLabel.text = "Unknown"
        }
        else{
            dishTypeLabel.text = result.recipe.dishType.first as? String
        }
    }
    func configure(for result: TrendingResults) {

        if result.recipe.dietLabels.isEmpty{
            dishTypeLabel.text = "Unknown"
        }
        else{
            dishTypeLabel.text = result.recipe.dishType.first as? String
        }
//        let arr = searchResult.recipe.dietLabels.map { (result) -> String in
//            return String(result!)
//                    }.joined(separator: ", ")
//
//        self. label.text = arr
    }
}
