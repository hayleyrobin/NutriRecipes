
import UIKit

class RecommendationsViewController: UIViewController{
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    var searchResults = [RecommendationsResult]() // fake array for data
    var hasSearched = false
    
    struct TableView {
      struct CellIdentifiers {
        static let recommendationsResultCell = "RecommendationsResultCell"
        static let noRecipesFoundCell = "NoRecipesFoundCell"
      }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.becomeFirstResponder() // dismiss keyboard

       tableView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        var cellNib = UINib(nibName: TableView.CellIdentifiers.recommendationsResultCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableView.CellIdentifiers.recommendationsResultCell)
        cellNib = UINib(nibName: TableView.CellIdentifiers.noRecipesFoundCell, bundle: nil)
        tableView.register(
          cellNib,
          forCellReuseIdentifier: TableView.CellIdentifiers.noRecipesFoundCell)


        }
    

}
// MARK:- Search Bar Delegate
extension RecommendationsViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        searchBar.resignFirstResponder() // dismiss keyboard
        searchResults = []
        if searchBar.text! != "Tomato"{
        for i in 0...2{
            let searchResult = RecommendationsResult()
              searchResult.recipeName = String(format: "Fake Result %d for", i)
              searchResult.recipeDescription = searchBar.text!
              searchResults.append(searchResult)
            }
        }
        hasSearched = true
        tableView.reloadData()
    }
    // extend search bar to status area
    func position(for bar: UIBarPositioning) -> UIBarPosition{
        return.topAttached
    }
}

// MARK:- Table View Delegate

// handles all the table view related delegate methods.

extension RecommendationsViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !hasSearched{
            return 0}
        else if searchResults.count == 0{
            return 1
        } else{
       return searchResults.count
     }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if searchResults.count == 0 {
          return tableView.dequeueReusableCell(
            withIdentifier: TableView.CellIdentifiers.noRecipesFoundCell,for: indexPath)
        }else {
            let cell = tableView.dequeueReusableCell(
              withIdentifier: TableView.CellIdentifiers.recommendationsResultCell,
            for: indexPath) as! RecommendationsResultCell
            
            let searchResult = searchResults[indexPath.row]
            cell.recipeNameLabel!.text = searchResult.recipeName
            cell.recipeDescriptionLabel!.text = searchResult.recipeDescription
            return cell
        }
}
    // deselect row with animation
    func tableView(
      _ tableView: UITableView,
      didSelectRowAt indexPath: IndexPath
    ) {
      tableView.deselectRow(at: indexPath, animated: true)
    }
      // only select rows when actual search results
    func tableView(
      _ tableView: UITableView,
      willSelectRowAt indexPath: IndexPath
    ) -> IndexPath? {
      if searchResults.count == 0 {
        return nil
      } else{
        return indexPath
      }
    }
    
    
}
