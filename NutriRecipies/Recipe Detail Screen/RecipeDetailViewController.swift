//
//  RecipeDetailViewController.swift
//  NutriRecipies
//
//  Created by Hayley Robinson on 11/29/21.
//

import UIKit

protocol RecipeDetailViewControllerDelegate: class {
    func addItemViewController(
    _ controller: RecipeDetailViewController,
    didFinishAdding item: TrendingResults)
    func addItemViewController(
    _ controller: RecipeDetailViewController,
    didFinishAdding item: RecommendationsResult)
}


class RecipeDetailViewController: UITableViewController, UITabBarControllerDelegate {
    var searchResult: RecommendationsResult!
    var trendingResult: TrendingResults!

    @IBOutlet weak var favoriteRecipeButton: UIBarButtonItem!
    
    weak var delegate: RecipeDetailViewControllerDelegate?

    @IBAction func addFav(){
        
        
//        let data = tabBarController?.viewControllers![1] as! UINavigationController
//        let favTableViewController = data.topViewController as! FavoriteRecipesViewController
//        if (searchResult != nil){
//            favTableViewController.searchResult = searchResult
//        }
//        else{
//            favTableViewController.trendingResult = trendingResult
//        }
//        tabBarController?.selectedIndex = 1
        
//        if (searchResult != nil){
//            let item = searchResult
//            delegate?.addItemViewController(self, didFinishAdding: item!)
//        }
//        else{
//            let item = trendingResult
//    //      item?.recipe = trendingResult.recipe
//            delegate?.addItemViewController(self, didFinishAdding: item!)
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.delegate = self

//        // Instantiate Second View Controller
//        if let favoriteRecipesController = storyboard?.instantiateViewController(withIdentifier: "FavoriteRecipesController") as? FavoriteRecipesViewController {
//           // Pass Data
//            if (searchResult != nil){
//                favoriteRecipesController.searchResult = searchResult
//            }
//            else{
//                favoriteRecipesController.trendingResult = trendingResult
//            }
//        }
    }
    

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.isKind(of: RecipeDetailViewController.self as AnyClass) {
            let viewController  = tabBarController.viewControllers?[1] as! FavoriteRecipesViewController
                if (searchResult != nil){
                    viewController.searchResult = self.searchResult
                }
                else{
                    viewController.trendingResult = self.trendingResult
                }
        }

        return true
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1{
            return "Ingredients"
        }
        return nil
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }
        else{
            if (searchResult != nil){
                return searchResult.recipe.ingredientLines.count
            }
            return trendingResult.recipe.ingredientLines.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeHeaderCell", for: indexPath)  as! RecipeHeaderCell
            if (searchResult != nil){
                cell.configure(for: searchResult)
            }
            else{
                cell.configure(for: trendingResult)
            }
            return cell
        }
        else{
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "IngredientsListCell", for: indexPath) as! IngredientsViewCell
            if (searchResult != nil){
                cell2.ingredientLabel!.text = searchResult.recipe.ingredientLines[indexPath.row]
            }
            else{
                cell2.ingredientLabel!.text = trendingResult.recipe.ingredientLines[indexPath.row]
            }

            //cell2.configure(for: searchResult)
            return cell2
        }
    }
    
    // MARK: - Table View Delegates
    // don't select row
    override func tableView(
      _ tableView: UITableView,
      willSelectRowAt indexPath: IndexPath
    ) -> IndexPath? {
      return nil
    }

    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
