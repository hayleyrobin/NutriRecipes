//
//  DirectionsViewCell.swift
//  NutriRecipies
//
//  Created by Hayley Robinson on 12/5/21.
//

import UIKit

class DirectionsViewCell: UITableViewCell {

    @IBOutlet weak var directionsButton: UIButton!
    @IBOutlet weak var sourceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(for result: RecommendationsResult) {
        sourceLabel.text = result.recipe.source
    }
    func configure(for result: TrendingResults) {
        sourceLabel.text = result.recipe.source
    }
}
