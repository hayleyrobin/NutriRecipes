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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
