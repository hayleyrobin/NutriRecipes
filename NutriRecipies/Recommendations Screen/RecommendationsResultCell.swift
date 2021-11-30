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
    var downloadTask: URLSessionDownloadTask?

    override func awakeFromNib() {
        super.awakeFromNib()
        let selectedView = UIView(frame: CGRect.zero)
        selectedView.backgroundColor = UIColor(named: "SearchBar")?.withAlphaComponent(0.5)
        selectedBackgroundView = selectedView
    }
    // MARK: - Helper Methods
    func configure(for result: RecommendationsResult) {
        recipeNameLabel.text = result.recipe.label

        if ((result.recipe.label?.isEmpty) == nil) {
            recipeNameLabel.text = "Unknown"
        }
        else {
            recipeDescriptionLabel.text = String(format: "%@ (%@)", result.recipe.source!, result.recipe.cuisineType.first!)
        }
        recipeImageView.image = UIImage(systemName: "square")
        if let previewURL = URL(string: result.recipe.image!) {
          downloadTask = recipeImageView.loadImage(url: previewURL)
        }
    }
    func configures(for result: TrendingResults) {
        recipeNameLabel.text = result.recipe.label

        if ((result.recipe.label?.isEmpty) == nil) {
            recipeNameLabel.text = "Unknown"
        }
        else {
            recipeDescriptionLabel.text = String(format: "%@ (%@)", result.recipe.source!, result.recipe.cuisineType.first!)
        }
        recipeImageView.image = UIImage(systemName: "square")
        if let previewURL = URL(string: result.recipe.image!) {
          downloadTask = recipeImageView.loadImage(url: previewURL)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
