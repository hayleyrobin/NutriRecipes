//
//  FavoriteRecipesViewController.swift
//  NutriRecipies
//
//  Created by Hayley Robinson on 12/4/21.
//

import UIKit

class FavoriteRecipesViewController: UIViewController {

    @IBOutlet weak var favoritesHeaderView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
// MARK:- Collection View Delegate

// handles all the collection view related delegate methods.

extension FavoriteRecipesViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "favoriteRecipeCell",
          for: indexPath) as! FavoriteRecipeViewCell
            
        return cell
    }
    
}
