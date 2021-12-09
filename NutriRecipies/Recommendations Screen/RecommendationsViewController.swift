
import UIKit

class RecommendationsViewController: UIViewController, RestrictionsControllerDelegate, UINavigationControllerDelegate{
    func restrictionsController(_ controller: RestrictionsTableViewController, didFinishAdding item: [ChecklistItem]) {
        restrictions = item
//        saveSearchItems()
        self.dismiss(animated: false, completion: nil)

    }
    func restrictionsControllerDidCancel(_ controller: RestrictionsTableViewController) {
        self.dismiss(animated: false, completion: nil)
    }

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
  
    var searchResults = [RecommendationsResult]() //  array for data
    var trendingResults = [TrendingResults]()
    var searchResultText = ""
    var hasSearched = false
    var isLoading = false
    var restrictions = [ChecklistItem]()
    var favoriteItems = [FavoriteRecipe]()
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
//        registerDefaults()

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

    /*
        func registerDefaults() {
          let dictionary = [ "RecipeIndex": -1 ]
            UserDefaults.standard.register(defaults: dictionary)
        }
        
        var indexOfSelectedChecklist: Int {
          get {
            return UserDefaults.standard.integer(
              forKey: "RecipeIndex")
          }
          set {
            UserDefaults.standard.set(
              newValue,
              forKey: "RecipeIndex")
          }
        }

     //    gets called after user presses back button
        override func viewDidAppear(_ animated: Bool) {
          super.viewDidAppear(animated)

          navigationController?.delegate = self

          let index = indexOfSelectedChecklist
            if index != -1{
            if hasSearched{
//                let recipe = searchResults[index]
                let indexPath = IndexPath(row: index, section: 0)
                let cell = tableView.cellForRow(at: indexPath)
                performSegue(
                  withIdentifier: "recipeSegue",
                  sender: cell)
            }
            else{
//                let recipe = trendingResults[index]
                let indexPath = IndexPath(row: index, section: 0)
                let cell = tableView.cellForRow(at: indexPath)
                self.performSegue(
                  withIdentifier: "recipeSegue",
                    sender: cell)
            }

          }
        }



       //  MARK: - Navigation Controller Delegates
        
        // called whenever the navigation controller shows a new screen.
        func navigationController(
          _ navigationController: UINavigationController,
          willShow viewController: UIViewController,
          animated: Bool
        ) {
          // Was the back button tapped?
          if viewController === self {
            indexOfSelectedChecklist = -1  // no recipe is currently selected.
          }
        }
    
*/

    // MARK:- Navigation
      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if(segue.identifier == "recipeSegue") {
         let recipeViewController = segue.destination as! RecipeDetailViewController

          guard let selectedRow = self.tableView.indexPathForSelectedRow
          else{
              return
          }
          if let cell = self.tableView.cellForRow(at: selectedRow) {
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
  //      Other method using UITableViewCell
         /* let cell = sender as! UITableViewCell
          let indexPath = tableView.indexPath(for: cell)
          if hasSearched{
              let searchResult = searchResults[indexPath!.row]
              recipeViewController.searchResult = searchResult
          }
          else{
              let trendingResult = trendingResults[indexPath!.row]
              recipeViewController.trendingResult = trendingResult
          }*/
       }
       else if(segue.identifier == "restrictionsSegue") {
          let nav = segue.destination as! UINavigationController
          let destination = nav.topViewController as! RestrictionsTableViewController
          destination.delegate = self
       }
      }

    // MARK:- Helper Methods
    
    // URL object for API string
    func recipeURL(searchText: String) -> URL{
        // all the special characters(#,*,space) are escaped
        let encodedText = searchText.addingPercentEncoding(
            withAllowedCharacters: CharacterSet.urlQueryAllowed)!

        var restriction = [String]()
        for i in restrictions{
            if i.checked{
                restriction.append(i.text.lowercased())
//                "&health=\(restriction)"
            }
        }
        if !restriction.isEmpty {
            var urlString = String(
            format: "https://api.edamam.com/api/recipes/v2?type=public&q=%@&app_id=6c3d1b83&app_key=76150e06464b0459d3ddb0985514e64a", encodedText)
            var label = ""
            
            for i in restriction{
                label = i
                if i == restriction.first{
                    urlString += "&health=\(label)"
                }
                else{
                    urlString += "&\(label)"
                }
                
            }
            let url = URL(string: urlString)
            print(url!)
            return url!
        }
        else{
            let urlString = String(
            format: "https://api.edamam.com/api/recipes/v2?type=public&q=%@&app_id=6c3d1b83&app_key=76150e06464b0459d3ddb0985514e64a", encodedText)
            let url = URL(string: urlString)
            return url!
        }
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
        message: "There was an error accessing the recipes." +
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
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchResultText = searchBar.text!
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
        // user defaults
//        indexOfSelectedChecklist = indexPath.row
        let cell = tableView.cellForRow(at: indexPath)

        performSegue(withIdentifier: "recipeSegue", sender: cell)
        // deselect row with animation
        tableView.deselectRow(at: indexPath, animated: true)
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
            return "\(searchResultText) Recipes"
        }
        return "Trending Recipes"
    }
}
