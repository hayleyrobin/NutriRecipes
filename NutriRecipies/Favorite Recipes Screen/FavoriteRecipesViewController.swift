//
//  FavoriteRecipesViewController.swift
//  NutriRecipies
//
//  Created by Hayley Robinson on 12/4/21.
//

import UIKit

//protocol FavoriteRecipesControllerDelegate: class {
//  func favoriteRecipesItemViewControllerDidCancel(
//    _ controller: FavoriteRecipesViewController)
//}

class FavoriteRecipesViewController: UIViewController, RecipeDetailViewControllerDelegate {
    func addItemViewController(_ controller: RecipeDetailViewController, didFinishAdding item: TrendingResults) {
        navigationController?.popViewController(animated: true)
    }

    func addItemViewController(_ controller: RecipeDetailViewController, didFinishAdding item: SearchRecipesResult) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var searchResult:  SearchRecipesResult!
    var trendingResult: TrendingResults!
    var favRecipes = [Any]()
//    @IBAction func removeFav(){
//        delegate?.favoriteRecipesItemViewControllerDidCancel(self)
//    }
//    weak var delegate: FavoriteRecipesControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
//    // MARK: - Navigation
//    override func prepare(
//      for segue: UIStoryboardSegue,
//      sender: Any?
//    ) {
//        if segue.identifier == "addFavRecipe" {
//        let controller = segue.destination as! RecipeDetailViewController
//            controller.delegate = self
//      }
//    }
}
// MARK:- Collection View Delegate

// handles all the collection view related delegate methods.

extension FavoriteRecipesViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "favoriteRecipeCell",
          for: indexPath) as! FavoriteRecipeViewCell
            
        if (searchResult != nil){
            cell.configure(for: searchResult)
        }
        else if (trendingResult != nil){
            cell.configure(for: trendingResult)
        }
        return cell
    }
    
}
