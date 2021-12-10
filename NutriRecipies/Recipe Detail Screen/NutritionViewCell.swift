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
   // func configure(for result: RecommendationsResult) {
        
   // }
    //func configure(for result: TrendingResults) {


//        let arr = searchResult.recipe.dietLabels.map { (result) -> String in
//            return String(result!)
//                    }.joined(separator: ", ")
//
//        self. label.text = arr
   // }
}
