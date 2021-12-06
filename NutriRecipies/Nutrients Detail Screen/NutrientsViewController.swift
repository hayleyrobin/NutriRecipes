//
//  NutrientsViewController.swift
//  NutriRecipies
//
//  Created by Hayley Robinson on 12/6/21.
//

import UIKit

class NutrientsViewController: UIViewController {
//    var searchResult: RecommendationsResult!
//    var trendingResult: TrendingResults!
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var dailyValueLabel: UILabel!
    @IBOutlet weak var servingsLabel: UILabel!
    @IBOutlet weak var calsLabel: UILabel!
    @IBOutlet weak var kcalsLabel: UILabel!
    
    @IBOutlet weak var fatGramsLabel: UILabel!
    @IBOutlet weak var fatPercentLabel: UILabel!
    @IBOutlet weak var satFatGramsLabel: UILabel!
    @IBOutlet weak var satFatPercentLabel: UILabel!
    @IBOutlet weak var transFatGramsLabel: UILabel!
    @IBOutlet weak var transFatPercentLabel: UILabel!
    @IBOutlet weak var monoSatGramsLabel: UILabel!
    @IBOutlet weak var monoSatPercentLabel: UILabel!
    @IBOutlet weak var polySatGramsLabel: UILabel!
    @IBOutlet weak var polySatPercentLabel: UILabel!
    
    @IBOutlet weak var carboGramsLabel: UILabel!
    @IBOutlet weak var carboPercentLabel: UILabel!
    @IBOutlet weak var fiberGramsLabel: UILabel!
    @IBOutlet weak var fiberPercentLabel: UILabel!
    @IBOutlet weak var sugarsGramsLabel: UILabel!
    @IBOutlet weak var sygarsPercentLabel: UILabel!
    
    @IBOutlet weak var proteinGramsLabel: UILabel!
    @IBOutlet weak var proteinPercentLabel: UILabel!
    @IBOutlet weak var cholestGramsLabel: UILabel!
    @IBOutlet weak var cholestPercentLabel: UILabel!
    @IBOutlet weak var sodiumGramsLabel: UILabel!
    @IBOutlet weak var sodiumPercentLabel: UILabel!
    @IBOutlet weak var calciumGramsLabel: UILabel!
    @IBOutlet weak var calciumPercentLabel: UILabel!
    @IBOutlet weak var magnesiumGramsLabel: UILabel!
    @IBOutlet weak var magnesiumPercentLabel: UILabel!
    @IBOutlet weak var potassiumGramsLabel: UILabel!
    @IBOutlet weak var potassiumPercentLabel: UILabel!
    @IBOutlet weak var ironGramsLabel: UILabel!
    @IBOutlet weak var ironPercentLabel: UILabel!
    @IBOutlet weak var zincGramsLabel: UILabel!
    @IBOutlet weak var zincPercentLabel: UILabel!
    @IBOutlet weak var phosphorousGramsLabel: UILabel!
    @IBOutlet weak var phosphorousPercentLabel: UILabel!
    
    @IBOutlet weak var vitAGramsLabel: UILabel!
    @IBOutlet weak var vitAPercentLabel: UILabel!
    @IBOutlet weak var vitCGramsLabel: UILabel!
    @IBOutlet weak var vitCPercentLabel: UILabel!
    @IBOutlet weak var thiaminGramsLabel: UILabel!
    @IBOutlet weak var thiaminPercentLabel: UILabel!
    @IBOutlet weak var niacinGramsLabel: UILabel!
    @IBOutlet weak var niacinPercentLabel: UILabel!
    @IBOutlet weak var vitB6GramsLabel: UILabel!
    @IBOutlet weak var vitB6PercentLabel: UILabel!
    @IBOutlet weak var folateGramsLabel: UILabel!
    @IBOutlet weak var folatePercentLabel: UILabel!
    @IBOutlet weak var vitKGramsLabel: UILabel!
    @IBOutlet weak var vitKPercentLabel: UILabel!
    @IBOutlet weak var sugarAlcoholsGramsLabel: UILabel!
    @IBOutlet weak var sugarAlcoholPercentLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: - Helper Methods
    func updateUI() {
//
//        if searchResult != nil {
//            nameLabel.text = searchResult.recipe.
//        }
//        else{
//
//        }
        
      
      
//      if searchResult.artist.isEmpty {
//        artistNameLabel.text = "Unknown"
//      } else {
//        artistNameLabel.text = searchResult.artist
//      }
//
//      kindLabel.text = searchResult.type
//      genreLabel.text = searchResult.genre
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
