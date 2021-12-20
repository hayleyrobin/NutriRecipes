//
//  RestrictionsTableViewController.swift
//  NutriRecipies
//
//  Created by Hayley Robinson on 12/8/21.
//

import UIKit

protocol RestrictionsControllerDelegate: class {
  func restrictionsControllerDidCancel(
    _ controller: RestrictionsTableViewController)
  func restrictionsController(
    _ controller: RestrictionsTableViewController,
    didFinishAdding item: [ChecklistItem]
  )
}

class RestrictionsTableViewController: UITableViewController {
    var delegate: RestrictionsControllerDelegate?

    @IBAction func cancelButton() {
        delegate?.restrictionsControllerDidCancel(self)
    }
    @IBAction func doneButton() {
        let itemArray = items
        delegate?.restrictionsController(self, didFinishAdding: itemArray)
    }

    var items = [ChecklistItem]()
    
    // define health restriction labels
    let healthLabels = ["Gluten-Free","Wheat-Free",
                        "Peanut-Free",
                        "Tree-Nut-Free",
                        "Soy-Free",
                        "Fish-Free",
                        "Shellfish-Free",
                        "Pork-Free",
                        "Red-Meat-Free",
                        "Crustacean-Free",
                        "Celery-Free",
                        "Sesame-Free",
                        "Lupine-Free",
                        "Mollusk-Free"]
    override func viewDidLoad() {
        super.viewDidLoad()

        for i in healthLabels{
            let rLabels = ChecklistItem()
            rLabels.text = i
            items.append(rLabels)
        }
        loadChecklistItems()
    }
    func configureCheckmark(
      for cell: UITableViewCell,
        with item: ChecklistItem
    ) {
        if item.checked {
            cell.accessoryType = .checkmark
          } else {
            cell.accessoryType = .none
      }
    }
    func configureText(
        for cell: UITableViewCell,
          with item: ChecklistItem
        ) {
        let label = cell.viewWithTag(100) as! UILabel
        label.text = item.text
    }
    func documentsDirectory() -> URL {
      let paths = FileManager.default.urls(
        for: .documentDirectory,
        in: .userDomainMask)
      return paths[0]
    }

    func dataFilePath() -> URL {
      return documentsDirectory().appendingPathComponent("NutriRecipes.plist")
    }
    // save which restriction items the user picks
    func saveChecklistItems() {
      let encoder = PropertyListEncoder()
      do {
        let data = try encoder.encode(items)
        try data.write(
          to: dataFilePath(),
          options: Data.WritingOptions.atomic)
      } catch {
        print("Error encoding item array: \(error.localizedDescription)")
      }
    }
    // load users' restriction items
    func loadChecklistItems() {
      let path = dataFilePath()
      if let data = try? Data(contentsOf: path) {
        let decoder = PropertyListDecoder()
        do {
            items = try decoder.decode(
                [ChecklistItem].self,
            from: data)
        } catch {
          print("Error decoding item array: \(error.localizedDescription)")
        }
      }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestrictionsCell", for: indexPath) as! RestrictionsTableViewCell
        let item = items[indexPath.row]
        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
        
        return cell
    }

    // toggle the checkmark
    override func tableView(
      _ tableView: UITableView,
      didSelectRowAt indexPath: IndexPath
    ) {
        if let cell = tableView.cellForRow(at: indexPath) {
        let item = items[indexPath.row]
          item.checked.toggle()
          configureCheckmark(for: cell, with: item)
        }
        tableView.deselectRow(at: indexPath, animated: true)
        saveChecklistItems()
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
