//
//  RecommendationsResultCell.swift
//  NutriRecipies
//
//  Created by Hayley Robinson on 11/20/21.
//

import UIKit

class RecommendationsResultCell: UITableViewCell {

    @IBOutlet var recipeNameLabel: UILabel!
    @IBOutlet var recipeDescriptionLabel: UILabel!
    @IBOutlet var recipeImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        let selectedView = UIView(frame: CGRect.zero)
        selectedView.backgroundColor = UIColor(named: "SearchBar")?.withAlphaComponent(0.5)
        selectedBackgroundView = selectedView
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
