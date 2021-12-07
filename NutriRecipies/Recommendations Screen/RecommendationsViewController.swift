
import UIKit

class RecommendationsViewController: UIViewController{
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
  
    var searchResults = [RecommendationsResult]() //  array for data
    var trendingResults = [TrendingResults]()
    var hasSearched = false
    var isLoading = false
    var dataTask: URLSessionDataTask?
    
    struct TableView {
      struct CellIdentifiers {
        static let recommendationsResultCell = "RecommendationsResultCell"
        static let noRecipesFoundCell = "NoRecipesFoundCell"
        static let loadingCell = "LoadingCell"

      }
    }
    //"https://api.edamam.com/api/recipes/v2?type=public&q=Recommended&app_id=6c3d1b83&app_key=76150e06464b0459d3ddb0985514e64a"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true

        searchBar.becomeFirstResponder() // dismiss keyboard

       tableView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        var cellNib = UINib(nibName: TableView.CellIdentifiers.recommendationsResultCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableView.CellIdentifiers.recommendationsResultCell)
       
        cellNib = UINib(nibName: TableView.CellIdentifiers.noRecipesFoundCell, bundle: nil)
        tableView.register(
          cellNib,
          forCellReuseIdentifier: TableView.CellIdentifiers.noRecipesFoundCell)

        cellNib = UINib(
          nibName: TableView.CellIdentifiers.loadingCell,
          bundle: nil)
        tableView.register(
          cellNib,
          forCellReuseIdentifier: TableView.CellIdentifiers.loadingCell)

        if !hasSearched {
            trendingResults = TrendingRecipes.trendingRecipies()
        }

    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     if segue.identifier == "recipeSegue" {
       let recipeViewController = segue.destination as! RecipeDetailViewController
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)
        if hasSearched{
            let searchResult = searchResults[indexPath!.row]
            recipeViewController.searchResult = searchResult
        }
        else{
            let trendingResult = trendingResults[indexPath!.row]
            recipeViewController.trendingResult = trendingResult
        }
     }
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
    func performStoreRequest(with url: URL) -> Data? {
        do {
            return try Data(contentsOf: url)
        }
        catch {
            print("Download Error: \(error.localizedDescription)")
            return nil
        }
    }
    
    func parse(data: Data) -> [RecommendationsResult] {
      do {
        let decoder = JSONDecoder()
        let result = try decoder.decode(
          ResultArray.self, from: data)
        
        return result.hits
        
      } catch {
        print("JSON Error: \(error)")
        return []
      }
    }
    // presents an alert controller with an error message.
    func showNetworkError() {
      let alert = UIAlertController(
        title: "Whoops...",
        message: "There was an error accessing the iTunes Store." +
        " Please try again.",
        preferredStyle: .alert)
      
      let action = UIAlertAction(
        title: "OK", style: .default, handler: nil)
      alert.addAction(action)
      present(alert, animated: true, completion: nil)
    }

}
// MARK:- Search Bar Delegate
extension RecommendationsViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        if !searchBar.text!.isEmpty
        {
            searchBar.resignFirstResponder() // dismiss keyboard
            dataTask?.cancel()
            isLoading = true
            tableView.reloadData()
            
            hasSearched = true
            searchResults = []
            
            // get URL object from API
            let url = recipeURL(searchText: searchBar.text!)
            print("URL: '\(url)'")
            if let data = performStoreRequest(with: url) {
              let results = parse(data: data)
              print("Got results: \(results)")              
            }
    
            
            let session = URLSession.shared
            // returns the JSON data that is received from the server URL
            dataTask = session.dataTask(with: url, completionHandler: {
                data, response, error in
                if let error = error as NSError?, error.code == -999 {
                  return 
                } else if let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 {
                    if let data = data {
                      self.searchResults = self.parse(data: data)
                      //self.searchResults.sort(by: <)
                      DispatchQueue.main.async {
                        self.isLoading = false
                        self.tableView.reloadData()
                      }
                      return
                    }

                } else {
                  print("Failure! \(response!)")
                }
                DispatchQueue.main.async {
                  self.hasSearched = false
                  self.isLoading = false
                  self.tableView.reloadData()
                  self.showNetworkError()
                }
              })
            dataTask?.resume()
        }
    }
    
    // go back to trending page when search is cleared
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            DispatchQueue.main.async {
                self.hasSearched = false
                self.isLoading = false
                self.tableView.reloadData()
                self.viewDidLoad()
            }
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
        if isLoading {
          return 1
        } else if !hasSearched {
            return trendingResults.count
        } else if searchResults.count == 0{
            return 1
        } else{
       return searchResults.count
     }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isLoading {
          let cell = tableView.dequeueReusableCell(
            withIdentifier: TableView.CellIdentifiers.loadingCell,
            for: indexPath)
              
          let spinner = cell.viewWithTag(100) as! UIActivityIndicatorView
          spinner.startAnimating()
          return cell
        }
        else if hasSearched && searchResults.count == 0 {
          return tableView.dequeueReusableCell(
            withIdentifier: TableView.CellIdentifiers.noRecipesFoundCell,for: indexPath)
        }
        else {
            let cell = tableView.dequeueReusableCell(
              withIdentifier: TableView.CellIdentifiers.recommendationsResultCell,
            for: indexPath) as! RecommendationsResultCell
            
            if hasSearched{
                let searchResult = searchResults[indexPath.row]
                cell.recipeNameLabel!.text = searchResult.recipe.label
                cell.recipeDescriptionLabel!.text = searchResult.recipe.source

                cell.configure(for: searchResult)
            }
            else{
                let trendingResult = trendingResults[indexPath.row]
                cell.recipeNameLabel!.text = trendingResult.recipe.label
                cell.recipeDescriptionLabel!.text = trendingResult.recipe.source
                
                cell.configure(for: trendingResult)
            }
            return cell
        }
    }

    func tableView(
      _ tableView: UITableView,
      didSelectRowAt indexPath: IndexPath
    ) {
        let cell = tableView.cellForRow(at: indexPath)
        // deselect row with animation
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "recipeSegue", sender: cell)
    }
      // only select rows when actual search results
    func tableView(
      _ tableView: UITableView,
      willSelectRowAt indexPath: IndexPath
    ) -> IndexPath? {
        if (hasSearched && searchResults.count == 0) || isLoading {
        return nil
      } else{
        return indexPath
      }
    }
    // Create a standard header that includes the returned text.
    func tableView(_ tableView: UITableView, titleForHeaderInSection
                                section: Int) -> String? {
        if hasSearched{
            return "Search Result Recipes"
        }
        return "Trending Recipes"
    }
    
}