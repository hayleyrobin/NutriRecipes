//
//  RecipeDetailViewController.swift
//  NutriRecipies
//
//  Created by Hayley Robinson on 11/29/21.
//  Table View Sections Source: https://letcreateanapp.com/2021/04/15/how-to-create-uitableview-with-sections-in-swift-5/
//  Rounded Corners for View Source: https://www.hackingwithswift.com/example-code/calayer/how-to-round-the-corners-of-a-uiview
//  Print Ingredients Array to Label: https://stackoverflow.com/questions/45211496/how-to-print-array-in-label

import UIKit

protocol RecipeDetailViewControllerDelegate: class {
    func addItemViewController(
    _ controller: RecipeDetailViewController,
    didFinishAdding item: TrendingResults)
    func addItemViewController(
    _ controller: RecipeDetailViewController,
    didFinishAdding item: SearchRecipesResult)
}


class RecipeDetailViewController: UITableViewController {
    var searchResult: SearchRecipesResult!
    var trendingResult: TrendingResults!
    var recommendedResult: RecommendationResults!

    
    weak var delegate: RecipeDetailViewControllerDelegate?
    //        if (searchResult != nil){
//            let item = searchResult
//            delegate?.addItemViewController(self, didFinishAdding: item!)
//        }
//        else{
//            let item = trendingResult
//    //      item?.recipe = trendingResult.recipe
//            delegate?.addItemViewController(self, didFinishAdding: item!)
//        }
    
    @IBAction func addFav(_ sender: Any) {
    }
    
    @IBAction func nutritionButton() {
        self.performSegue(withIdentifier: "ShowNutrition", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "ShowNutrition" {
        let nutritionViewController = segue.destination as! NutrientsViewController
        if searchResult != nil{
            nutritionViewController.searchResult = searchResult
        }
        else if trendingResult != nil{
            nutritionViewController.trendingResult = trendingResult
        }
        else{
            nutritionViewController.recommendationResult = recommendedResult
        }
      }
      else if segue.identifier == "favoritesSegue"{
          let favoritesViewController = segue.destination as! FavoriteRecipesViewController
            if searchResult != nil{
                favoritesViewController.searchResult = searchResult
            }
            else{
                favoritesViewController.trendingResult = trendingResult
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: - Helper Functions
    
    // directions button should take user to the selected recipe's page
    @IBAction func openInStore() {
        if(searchResult != nil)
        {
            if let url = URL(string: searchResult.recipe.url!) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        else if(trendingResult != nil){
            if let url = URL(string: trendingResult.recipe.url!) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        else{
            if let url = URL(string: recommendedResult.recipe.url!) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1{
            return "Details"
        }
        else if section == 2{
            return "Ingredients"
        }
        else if section == 3{
            return "Directions"
        }
        return nil
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }
        else if(section == 1){
            return 1
        }
        else if(section == 2){
            if (searchResult != nil){
                return searchResult.recipe.ingredientLines.count
            }
            else if(trendingResult != nil){
                return trendingResult.recipe.ingredientLines.count
            }
            else{
                return recommendedResult.recipe.ingredientLines.count
            }
        }
        else{
            return 1
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeHeaderCell", for: indexPath) as! RecipeHeaderCell
            if (searchResult != nil){
                cell.configure(for: searchResult)
            }
            else if (trendingResult != nil){
                cell.configure(for: trendingResult)
            }
            else {
                cell.configure(for: recommendedResult)
            }
            return cell
        }
        else if indexPath.section == 1{
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "NutritionCell", for: indexPath) as! NutritionViewCell
//            if (searchResult != nil){
//                cell1.configure(for: searchResult)
//            }
//            else{
//                cell1.configure(for: trendingResult)
//            }
            return cell1
        }
        else if indexPath.section == 2{
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "IngredientsListCell", for: indexPath) as! IngredientsViewCell
            if (searchResult != nil){
                cell2.ingredientLabel!.text = searchResult.recipe.ingredientLines[indexPath.row]
            }
            else if (trendingResult != nil){
                cell2.ingredientLabel!.text = trendingResult.recipe.ingredientLines[indexPath.row]
            }
            else{
                cell2.ingredientLabel!.text = recommendedResult.recipe.ingredientLines[indexPath.row]
            }
            return cell2
        }
        else{
            let cell3 = tableView.dequeueReusableCell(withIdentifier: "DirectionsCell", for: indexPath) as! DirectionsViewCell
            if(searchResult != nil){
                cell3.configure(for: searchResult)
            }
            else if(trendingResult != nil){
                cell3.configure(for: trendingResult)
            }
            else{
                cell3.configure(for: recommendedResult)
            }
            return cell3
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
