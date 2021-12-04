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
}
