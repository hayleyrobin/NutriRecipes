/*
 Search Bar Source:
 https://www.raywenderlich.com/4363809-uisearchcontroller-tutorial-getting-started#c-rate
 Automatic Cell Size: https://www.hackingwithswift.com/example-code/uikit/how-to-make-uitableviewcells-auto-resize-to-their-content
 Segue without sender UITableViewCell using didSelectForRowAtIndexPath: https://github.com/CEWendel/SWTableViewCell/issues/18
 */

import UIKit

class SearchRecipesViewController: UIViewController, RestrictionsControllerDelegate, UINavigationControllerDelegate
    {
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
  
    var searchResults = [SearchRecipesResult]() //  array for data
    var trendingResults = [TrendingResults]()
    var recommendedResults = [RecommendationResults]()
    var searchResultText = ""
    var hasSearched = false
    var isLoading = false
    var isTrending = false
    var restrictions = [ChecklistItem]()
//    var favoriteItems = [FavoriteRecipe]()
    var dataTask: URLSessionDataTask?
    
    
    struct TableView {
      struct CellIdentifiers {
        static let searchRecipesResultCell = "SearchRecipesResultCell"
        static let noRecipesFoundCell = "NoRecipesFoundCell"
        static let loadingCell = "LoadingCell"
      }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerDefaults()

        navigationController?.navigationBar.prefersLargeTitles = true
        searchBar.becomeFirstResponder() // dismiss keyboard
        tableView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        var cellNib = UINib(nibName: TableView.CellIdentifiers.searchRecipesResultCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableView.CellIdentifiers.searchRecipesResultCell)
       
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
            recommendedResults = RecommendationRecipes.recommendationRecipies()
            trendingResults = TrendingRecipes.trendingRecipies()
        }
    }
    // MARK: - Navigation Controller Delegates
    func registerDefaults() {
      let dictionary = [ "RecipesIndex": -1 ]
      UserDefaults.standard.register(defaults: dictionary)
    }

    func navigationController(
      _ navigationController: UINavigationController,
      willShow viewController: UIViewController,
      animated: Bool
    ) {
      // Was the back button tapped?
      if viewController === self {
        UserDefaults.standard.set(-1, forKey: "RecipesIndex")
      }
    }
    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)

      navigationController?.delegate = self

      let index = UserDefaults.standard.integer(
        forKey: "RecipesIndex")
        
      if index != -1 {

        if !hasSearched{
            if isTrending{
                
                let indexPath = IndexPath(row: index, section: 1)
                print(indexPath.row)
                print(indexPath.section)
                let cell = tableView.cellForRow(at: indexPath)
                self.performSegue(
                  withIdentifier: "recipeSegue",
                    sender: cell)
            }
            else{
                print("h")
                self.moveOnRecipeDetail(index: index)
            }
        }

//        else {
//            let checklist = trendingResults[index]
//            performSegue(
//              withIdentifier: "recipeSegue",
//              sender: checklist)
//        }

      }
    }

    // MARK:- Navigation
      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if(segue.identifier == "recipeSegue") {
         let recipeViewController = segue.destination as! RecipeDetailViewController
//
//          guard let selectedRow = self.tableView.indexPathForSelectedRow
//          else{
//              return
//          }
//          if let cell = self.tableView.cellForRow(at: selectedRow) {
//              let indexPath = tableView.indexPath(for: cell)
//              if hasSearched{
//                  let searchResult = searchResults[indexPath!.row]
//                  recipeViewController.searchResult = searchResult
//              }
//              else{
//                  let trendingResult = trendingResults[indexPath!.row]
//                  recipeViewController.trendingResult = trendingResult
//              }
//          }
  //      Other method using UITableViewCell
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)
            if hasSearched{
              let searchResult = searchResults[indexPath!.row]
              recipeViewController.searchResult = searchResult
            }
            else{
                let trendingResult = trendingResults[indexPath!.row]
                recipeViewController.trendingResult = trendingResult
                isTrending = true
                print(isTrending)
            }
       }
       else if(segue.identifier == "restrictionsSegue") {
          let nav = segue.destination as! UINavigationController
          let destination = nav.topViewController as! RestrictionsTableViewController
          destination.delegate = self
       }
      }
    
    // instantiate detail recipe for collection view cell
    func moveOnRecipeDetail(index: Int) {
        guard let detailViewController = storyboard?.instantiateViewController(identifier: "RecipeDetailViewController") as? RecipeDetailViewController
        else{
            return
        }
        detailViewController.recommendedResult = recommendedResults[index]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
//    // MARK:- Save
//    func documentsDirectory() -> URL {
//      let paths = FileManager.default.urls(
//        for: .documentDirectory,
//        in: .userDomainMask)
//      return paths[0]
//    }
//
//    func dataFilePath() -> URL {
//      return documentsDirectory().appendingPathComponent("NutriRecipes.plist")
//    }
//    // save which restriction items the user picks
//    func saveChecklistItems() {
//      let encoder = PropertyListEncoder()
//      do {
//        let data = try encoder.encode(isTrending)
//        try data.write(
//          to: dataFilePath(),
//          options: Data.WritingOptions.atomic)
//      } catch {
//        print("Error encoding item array: \(error.localizedDescription)")
//      }
//    }
//    // load users' restriction items
//    func loadChecklistItems() {
//      let path = dataFilePath()
//      if let data = try? Data(contentsOf: path) {
//        let decoder = try! 
//        let decoder = PropertyListDecoder()
//        do {
//            isTrending = try decoder.decode(
//                Bool.self,
//            from: data)
//        } catch {
//          print("Error decoding item array: \(error.localizedDescription)")
//        }
//      }
//    }
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
    
    func parse(data: Data) -> [SearchRecipesResult] {
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
extension SearchRecipesViewController: UISearchBarDelegate{
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
extension SearchRecipesViewController: UITableViewDelegate, UITableViewDataSource
{
     func numberOfSections(in tableView: UITableView) -> Int {
        if !hasSearched && !isLoading && searchResults.count == 0{
            return 2
        }
        else{
            return 1
        }
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isLoading {
            return 1
        }
        else if !hasSearched && section == 0{
            return 1
        } else if !hasSearched && section == 1{
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
            if hasSearched{
                let cell = tableView.dequeueReusableCell(
                  withIdentifier: TableView.CellIdentifiers.searchRecipesResultCell,
                for: indexPath) as! SearchRecipesResultCell
                
                let searchResult = searchResults[indexPath.row]
                cell.recipeNameLabel!.text = searchResult.recipe.label
                cell.recipeDescriptionLabel!.text = searchResult.recipe.source

                cell.configure(for: searchResult)
                return cell
            }
            else{
                if indexPath.section == 0 && !hasSearched{
                    let cell = tableView.dequeueReusableCell(
                        withIdentifier: "RecommendedTableViewCell", for: indexPath) as! RecommendedTableViewCell
                    cell.recommendedRecipe = recommendedResults
                    cell.index = indexPath.row
                    cell.didSelectRecipeClosure = { rIndex in
                        if let recipeIndex = rIndex{
                            self.moveOnRecipeDetail(index: recipeIndex)
                        }
                    }
                    return cell
                }
                else{
                    let cell = tableView.dequeueReusableCell(
                      withIdentifier: TableView.CellIdentifiers.searchRecipesResultCell,
                    for: indexPath) as! SearchRecipesResultCell
                    
                    let trendingResult = trendingResults[indexPath.row]
                    cell.recipeNameLabel!.text = trendingResult.recipe.label
                    cell.recipeDescriptionLabel!.text = trendingResult.recipe.source
                    
                    cell.configure(for: trendingResult)
                    return cell
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && !hasSearched {
            return 327 // fixed size
        }
        return UITableView.automaticDimension // automatic cell size
    }

    func tableView(
      _ tableView: UITableView,
      didSelectRowAt indexPath: IndexPath
    ) {
        // user defaults
//        indexOfSelectedChecklist = indexPath.row
        UserDefaults.standard.set(
           indexPath.row,
           forKey: "RecipesIndex")
        if (!hasSearched && indexPath.section != 0 ) || hasSearched{
            let cell = tableView.cellForRow(at: indexPath)
            performSegue(withIdentifier: "recipeSegue", sender: cell)
            // deselect row with animation
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
      // only select rows when actual search results
    func tableView(
      _ tableView: UITableView,
      willSelectRowAt indexPath: IndexPath) -> IndexPath? {
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
        else if !hasSearched && section == 0{
            return "Recommended Recipes"
        }
        return "Trending Recipes"
    }
    
//    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
//        view.tintColor = UIColor.systemGray5
//        let header = view as! UITableViewHeaderFooterView
//        header.textLabel?.textColor = UIColor.white
//
//    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 35.0
//    }
}
