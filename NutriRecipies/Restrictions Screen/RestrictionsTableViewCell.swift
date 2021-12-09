//
//  RestrictionsTableViewCell.swift
//  NutriRecipies
//
//  Created by Hayley Robinson on 12/8/21.
//

import UIKit

class RestrictionsTableViewCell: UITableViewCell {
    @IBOutlet weak var restrictionsLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configures(for result: String){
        restrictionsLabel.text  = result
    }

}
