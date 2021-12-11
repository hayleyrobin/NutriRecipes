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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configures(for result: String){
        restrictionsLabel.text  = result
    }

}
