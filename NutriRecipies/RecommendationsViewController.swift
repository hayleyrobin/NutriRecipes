
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
    // MARK: - Helper Methods
    
    // URL object for API string
    func recipeURL(searchText: String) -> URL {
        // all the special characters(#,*,space) are escaped
        let encodedText = searchText.addingPercentEncoding(
            withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let urlString = String(
        format: "https://api.edamam.com/api/recipes/v2?type=public&q=%@&app_id=6c3d1b83&app_key=76150e06464b0459d3ddb0985514e64a", encodedText)
        let url = URL(string: urlString)
        return url!
    }
    
    // returns string object with the data received from the server from URL
    func performStoreRequest(with url: URL) -> String? {
        do {
            return try String(contentsOf: url, encoding: .utf8)
        }
        catch {
            print("Download Error: \(error.localizedDescription)")
            return nil
        }
    }

}
// MARK:- Search Bar Delegate
extension RecommendationsViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        if !searchBar.text!.isEmpty
        {
            searchBar.resignFirstResponder() // dismiss keyboard
            hasSearched = true
            searchResults = []
            
            // get URL object from API
            let url = recipeURL(searchText: searchBar.text!)
            print("URL: '\(url)'")
            
            // returns the JSON data that is received from the server URL
            if let jsonString = performStoreRequest(with: url)
            {
              print("Received JSON string '\(jsonString)'")
            }

            tableView.reloadData()
        }
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
