//
//  RecommendedTableViewCell.swift
//  NutriRecipies
//
//  Created by Hayley Robinson on 12/10/21.
//

import UIKit

class RecommendedTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var recommendedRecipe: [RecommendationResults]? {
        didSet{
            collectionView.reloadData()
            print("pp")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("boo")
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
extension RecommendedTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendedRecipe!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendedCollectionViewCell", for: indexPath) as! RecommendedCollectionViewCell
        print("yy")
        let result = recommendedRecipe![indexPath.row]
        print("yer")
        cell.configure(for: result)
        print("lll")
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 193, height: 304)
    }
    
}
