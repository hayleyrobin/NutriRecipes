//
//  NutrientsViewController.swift
//  NutriRecipies
//
//  Created by Hayley Robinson on 12/6/21.
//

import UIKit

class NutrientsViewController: UIViewController {
    
    var searchResult: SearchRecipesResult!
    var trendingResult: TrendingResults!
    var recommendationResult: RecommendationResults!
    
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var dailyValueLabel: UILabel!
    @IBOutlet weak var servingsLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
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
    @IBOutlet weak var sugarsPercentLabel: UILabel!
    
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
    @IBOutlet weak var vitB12GramsLabel: UILabel!
    @IBOutlet weak var vitB12PercentLabel: UILabel!
    @IBOutlet weak var vitKGramsLabel: UILabel!
    @IBOutlet weak var vitKPercentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (trendingResult != nil){
            updateUI()
        }
        else if (searchResult != nil){
            updateUI()
        }
        else if(recommendationResult != nil){
            updateUI()
        }
    }
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      transitioningDelegate = self
    }

    // MARK: - Helper Methods
    
    func updateUI() {
        
        if searchResult != nil{
            let servings = searchResult.recipe.yield!
            let calories = searchResult.recipe.calories! / Double(searchResult.recipe.yield!)

            dailyValueLabel.text = String(format: "%.0f", searchResult.recipe.totalDaily.kcals!.quantity! / Double(servings)) + "%"
            servingsLabel.text = String(format: "%.0f", servings)
            caloriesLabel.text = String(format: "%.0f", calories)
            kcalsLabel.text = String (format: "%.0f", (searchResult.recipe.totalNutrients.kcals!.quantity! / Double(servings)))
            
            fatGramsLabel.text = "Fat: " + String(format: "%.0f", searchResult.recipe.totalNutrients.fat!.quantity! / Double(servings)) + searchResult.recipe.totalNutrients.fat!.unit!
            fatPercentLabel.text = String(format: "%.0f",searchResult.recipe.totalDaily.fat!.quantity! / Double(servings)) + searchResult.recipe.totalDaily.fat!.unit!
            
            satFatGramsLabel.text = "Saturated: " + String(format: "%.0f", searchResult.recipe.totalNutrients.satFat!.quantity! / Double(servings)) + searchResult.recipe.totalNutrients.satFat!.unit!
            satFatPercentLabel.text = String(format: "%.0f",searchResult.recipe.totalDaily.satFat!.quantity! / Double(servings)) + searchResult.recipe.totalDaily.satFat!.unit!
            
            satFatGramsLabel.text = "Saturated: " + String(format: "%.0f", searchResult.recipe.totalNutrients.satFat!.quantity! / Double(servings)) + searchResult.recipe.totalNutrients.satFat!.unit!
            satFatPercentLabel.text = String()
            
            if(searchResult.recipe.totalNutrients.transFat == nil){
                transFatGramsLabel.text = "Trans: 0g"
            }
            else{
                transFatGramsLabel.text = "Trans: " + String(format: "%.0f", searchResult.recipe.totalNutrients.transFat!.quantity! / Double(servings)) + searchResult.recipe.totalNutrients.transFat!.unit!
            }
            if(searchResult.recipe.totalDaily.transFat == nil )
            {
                transFatPercentLabel.text = "0%"
            }
            else{
                transFatPercentLabel.text = String(format: "%.0f",(searchResult.recipe.totalDaily.transFat!.quantity! ) / Double(servings)) + searchResult.recipe.totalDaily.transFat!.unit!
            }
            
            if(searchResult.recipe.totalNutrients.monoFat == nil){
                monoSatGramsLabel.text = "Monounsaturated: 0g"
            }
            else{
                monoSatGramsLabel.text = "Monounsaturated: " + String(format: "%.0f", searchResult.recipe.totalNutrients.monoFat!.quantity! / Double(servings)) + searchResult.recipe.totalNutrients.monoFat!.unit!
            }
            if(searchResult.recipe.totalDaily.monoFat == nil){
                monoSatPercentLabel.text = "0%"
            }
            else{
                monoSatPercentLabel.text = String(format: "%.0f",searchResult.recipe.totalDaily.monoFat!.quantity! / Double(servings)) + searchResult.recipe.totalDaily.monoFat!.unit!
            }
            if(searchResult.recipe.totalNutrients.polyunFat == nil){
                polySatGramsLabel.text = "Polyunsaturated: 0g"
            }
            else{
                polySatGramsLabel.text = "Polyunsaturated: " + String(format: "%.0f", searchResult.recipe.totalNutrients.polyunFat!.quantity! / Double(servings)) + searchResult.recipe.totalNutrients.polyunFat!.unit!
            }
            if(searchResult.recipe.totalDaily.polyunFat == nil){
                polySatPercentLabel.text = "0%"
            }
            else{
                polySatPercentLabel.text = String(format: "%.0f",searchResult.recipe.totalDaily.polyunFat!.quantity! / Double(servings)) + searchResult.recipe.totalDaily.polyunFat!.unit!
            }


            carboGramsLabel.text = "Carbohydrates: " + String(format: "%.0f", searchResult.recipe.totalNutrients.carbs!.quantity! / Double(servings)) + searchResult.recipe.totalNutrients.carbs!.unit!
            carboPercentLabel.text = String(format: "%.0f",searchResult.recipe.totalDaily.carbs!.quantity! / Double(servings)) + searchResult.recipe.totalDaily.carbs!.unit!

            fiberGramsLabel.text = "Dietary Fiber: " + String(format: "%.0f", searchResult.recipe.totalNutrients.fiber!.quantity! / Double(servings)) + searchResult.recipe.totalNutrients.fiber!.unit!
            fiberPercentLabel.text = String(format: "%.0f",searchResult.recipe.totalDaily.fiber!.quantity! / Double(servings)) + searchResult.recipe.totalDaily.fiber!.unit!

            sugarsGramsLabel.text = "Sugars: " + String(format: "%.0f", searchResult.recipe.totalNutrients.sugars!.quantity! / Double(servings)) + searchResult.recipe.totalNutrients.sugars!.unit!
            if(searchResult.recipe.totalDaily.sugars == nil){
                sugarsPercentLabel.text = "0%"
            }
            else{
                sugarsPercentLabel.text = String(format: "%.0f",searchResult.recipe.totalDaily.sugars!.quantity! / Double(servings)) + searchResult.recipe.totalDaily.sugars!.unit!
            }


            proteinGramsLabel.text = "Protein: " + String(format: "%.0f", searchResult.recipe.totalNutrients.protein!.quantity! / Double(servings)) + searchResult.recipe.totalNutrients.protein!.unit!
            proteinPercentLabel.text = String(format: "%.0f",searchResult.recipe.totalDaily.protein!.quantity! / Double(servings)) + searchResult.recipe.totalDaily.protein!.unit!

            cholestGramsLabel.text = "Cholestorol: " + String(format: "%.0f", searchResult.recipe.totalNutrients.cholesterol!.quantity! / Double(servings)) + searchResult.recipe.totalNutrients.cholesterol!.unit!
            cholestPercentLabel.text = String(format: "%.0f",searchResult.recipe.totalDaily.cholesterol!.quantity! / Double(servings)) + searchResult.recipe.totalDaily.cholesterol!.unit!

            sodiumGramsLabel.text = "Sodium: " + String(format: "%.0f", searchResult.recipe.totalNutrients.NA!.quantity! / Double(servings)) + searchResult.recipe.totalNutrients.NA!.unit!
            sodiumPercentLabel.text = String(format: "%.0f",searchResult.recipe.totalDaily.NA!.quantity! / Double(servings)) + searchResult.recipe.totalDaily.NA!.unit!

            calciumGramsLabel.text = "Calcium: " + String(format: "%.0f", searchResult.recipe.totalNutrients.CA!.quantity! / Double(servings)) + searchResult.recipe.totalNutrients.CA!.unit!
            calciumPercentLabel.text = String(format: "%.0f",searchResult.recipe.totalDaily.CA!.quantity! / Double(servings)) + searchResult.recipe.totalDaily.CA!.unit!

            magnesiumGramsLabel.text = "Magnesium: " + String(format: "%.0f", searchResult.recipe.totalNutrients.MG!.quantity! / Double(servings)) + searchResult.recipe.totalNutrients.MG!.unit!
            magnesiumPercentLabel.text = String(format: "%.0f",searchResult.recipe.totalDaily.MG!.quantity! / Double(servings)) + searchResult.recipe.totalDaily.MG!.unit!

            potassiumGramsLabel.text = "Potassium: " + String(format: "%.0f", searchResult.recipe.totalNutrients.K!.quantity! / Double(servings)) + searchResult.recipe.totalNutrients.K!.unit!
            potassiumPercentLabel.text = String(format: "%.0f",searchResult.recipe.totalDaily.K!.quantity! / Double(servings)) + searchResult.recipe.totalDaily.K!.unit!

            ironGramsLabel.text = "Iron: " + String(format: "%.0f", searchResult.recipe.totalNutrients.FE!.quantity! / Double(servings)) + searchResult.recipe.totalNutrients.FE!.unit!
            ironPercentLabel.text = String(format: "%.0f",searchResult.recipe.totalDaily.FE!.quantity! / Double(servings)) + searchResult.recipe.totalDaily.FE!.unit!

            zincGramsLabel.text = "Zinc: " + String(format: "%.0f", searchResult.recipe.totalNutrients.ZN!.quantity! / Double(servings)) + searchResult.recipe.totalNutrients.ZN!.unit!
            zincPercentLabel.text = String(format: "%.0f",searchResult.recipe.totalDaily.ZN!.quantity! / Double(servings)) + searchResult.recipe.totalDaily.ZN!.unit!

            phosphorousGramsLabel.text = "Phosphorous: " + String(format: "%.0f", searchResult.recipe.totalNutrients.P!.quantity! / Double(servings)) + searchResult.recipe.totalNutrients.P!.unit!
            phosphorousPercentLabel.text = String(format: "%.0f",searchResult.recipe.totalDaily.P!.quantity! / Double(servings)) + searchResult.recipe.totalDaily.P!.unit!

            vitAGramsLabel.text = "Vitamin A: " + String(format: "%.0f", searchResult.recipe.totalNutrients.vitaminA!.quantity! / Double(servings)) + searchResult.recipe.totalNutrients.vitaminA!.unit!
            vitAPercentLabel.text = String(format: "%.0f",searchResult.recipe.totalDaily.vitaminA!.quantity! / Double(servings)) + searchResult.recipe.totalDaily.vitaminA!.unit!

            vitCGramsLabel.text = "Vitamin C: " + String(format: "%.0f", searchResult.recipe.totalNutrients.vitaminC!.quantity! / Double(servings)) + searchResult.recipe.totalNutrients.vitaminC!.unit!
            vitCPercentLabel.text = String(format: "%.0f",searchResult.recipe.totalDaily.vitaminC!.quantity! / Double(servings)) + searchResult.recipe.totalDaily.vitaminC!.unit!

            thiaminGramsLabel.text = "Thiamin: " + String(format: "%.0f", searchResult.recipe.totalNutrients.thiamin!.quantity! / Double(servings)) + searchResult.recipe.totalNutrients.thiamin!.unit!
            thiaminPercentLabel.text = String(format: "%.0f",searchResult.recipe.totalDaily.thiamin!.quantity! / Double(servings)) + searchResult.recipe.totalDaily.thiamin!.unit!

            niacinGramsLabel.text = "Niacin: " + String(format: "%.0f", searchResult.recipe.totalNutrients.niacin!.quantity! / Double(servings)) + searchResult.recipe.totalNutrients.niacin!.unit!
            niacinPercentLabel.text = String(format: "%.0f",searchResult.recipe.totalDaily.niacin!.quantity! / Double(servings)) + searchResult.recipe.totalDaily.niacin!.unit!

            vitB6GramsLabel.text = "Vitamin B6: " + String(format: "%.0f", searchResult.recipe.totalNutrients.vitaminB6!.quantity! / Double(servings)) + searchResult.recipe.totalNutrients.vitaminB6!.unit!
            vitB6PercentLabel.text = String(format: "%.0f",searchResult.recipe.totalDaily.vitaminB6!.quantity! / Double(servings)) + searchResult.recipe.totalDaily.vitaminB6!.unit!

            vitB12GramsLabel.text = "VitaminB12: " + String(format: "%.0f", searchResult.recipe.totalNutrients.vitaminB12!.quantity! / Double(servings)) + searchResult.recipe.totalNutrients.vitaminB12!.unit!
            vitB12PercentLabel.text = String(format: "%.0f",searchResult.recipe.totalDaily.vitaminB12!.quantity! / Double(servings)) + searchResult.recipe.totalDaily.vitaminB12!.unit!

            vitKGramsLabel.text = "Vitamin K: " + String(format: "%.0f", searchResult.recipe.totalNutrients.vitaminK!.quantity! / Double(servings)) + searchResult.recipe.totalNutrients.vitaminK!.unit!
            vitKPercentLabel.text = String(format: "%.0f",searchResult.recipe.totalDaily.vitaminK!.quantity! / Double(servings)) + searchResult.recipe.totalDaily.vitaminK!.unit!
            
        }
        else if(trendingResult != nil){
            let servings = trendingResult.recipe.yield!
            let calories = trendingResult.recipe.calories! / Double(trendingResult.recipe.yield!)

            dailyValueLabel.text = String(format: "%.0f", trendingResult.recipe.totalDaily.kcals!.quantity! / Double(servings)) + "%"
            servingsLabel.text = String(format: "%.0f", servings)
            caloriesLabel.text = String(format: "%.0f", calories)
            kcalsLabel.text = String (format: "%.0f", (trendingResult.recipe.totalNutrients.kcals!.quantity! / Double(servings)))
            
            fatGramsLabel.text = "Fat: " + String(format: "%.0f", trendingResult.recipe.totalNutrients.fat!.quantity! / Double(servings)) + trendingResult.recipe.totalNutrients.fat!.unit!
            fatPercentLabel.text = String(format: "%.0f",trendingResult.recipe.totalDaily.fat!.quantity! / Double(servings)) + trendingResult.recipe.totalDaily.fat!.unit!
            
            satFatGramsLabel.text = "Saturated: " + String(format: "%.0f", trendingResult.recipe.totalNutrients.satFat!.quantity! / Double(servings)) + trendingResult.recipe.totalNutrients.satFat!.unit!
            satFatPercentLabel.text = String(format: "%.0f",trendingResult.recipe.totalDaily.satFat!.quantity! / Double(servings)) + trendingResult.recipe.totalDaily.satFat!.unit!
            
            satFatGramsLabel.text = "Saturated: " + String(format: "%.0f", trendingResult.recipe.totalNutrients.satFat!.quantity! / Double(servings)) + trendingResult.recipe.totalNutrients.satFat!.unit!
            satFatPercentLabel.text = String()
            
            if(trendingResult.recipe.totalNutrients.transFat == nil){
                transFatGramsLabel.text = "Trans: 0g"
            }
            else{
                transFatGramsLabel.text = "Trans: " + String(format: "%.0f", trendingResult.recipe.totalNutrients.transFat!.quantity! / Double(servings)) + trendingResult.recipe.totalNutrients.transFat!.unit!
            }
            if(trendingResult.recipe.totalDaily.transFat == nil )
            {
                transFatPercentLabel.text = "0%"
            }
            else{
                transFatPercentLabel.text = String(format: "%.0f",(trendingResult.recipe.totalDaily.transFat!.quantity! ) / Double(servings)) + trendingResult.recipe.totalDaily.transFat!.unit!
            }
            
            if(trendingResult.recipe.totalNutrients.monoFat == nil){
                monoSatGramsLabel.text = "Monounsaturated: 0g"
            }
            else{
                monoSatGramsLabel.text = "Monounsaturated: " + String(format: "%.0f", trendingResult.recipe.totalNutrients.monoFat!.quantity! / Double(servings)) + trendingResult.recipe.totalNutrients.monoFat!.unit!
            }
            if(trendingResult.recipe.totalDaily.monoFat == nil){
                monoSatPercentLabel.text = "0%"
            }
            else{
                monoSatPercentLabel.text = String(format: "%.0f",trendingResult.recipe.totalDaily.monoFat!.quantity! / Double(servings)) + trendingResult.recipe.totalDaily.monoFat!.unit!
            }
            if(trendingResult.recipe.totalNutrients.polyunFat == nil){
                polySatGramsLabel.text = "Polyunsaturated: 0g"
            }
            else{
                polySatGramsLabel.text = "Polyunsaturated: " + String(format: "%.0f", trendingResult.recipe.totalNutrients.polyunFat!.quantity! / Double(servings)) + trendingResult.recipe.totalNutrients.polyunFat!.unit!
            }
            if(trendingResult.recipe.totalDaily.polyunFat == nil){
                polySatPercentLabel.text = "0%"
            }
            else{
                polySatPercentLabel.text = String(format: "%.0f",trendingResult.recipe.totalDaily.polyunFat!.quantity! / Double(servings)) + trendingResult.recipe.totalDaily.polyunFat!.unit!
            }
            carboGramsLabel.text = "Carbohydrates: " + String(format: "%.0f", trendingResult.recipe.totalNutrients.carbs!.quantity! / Double(servings)) + trendingResult.recipe.totalNutrients.carbs!.unit!
            carboPercentLabel.text = String(format: "%.0f",trendingResult.recipe.totalDaily.carbs!.quantity! / Double(servings)) + trendingResult.recipe.totalDaily.carbs!.unit!

            fiberGramsLabel.text = "Dietary Fiber: " + String(format: "%.0f", trendingResult.recipe.totalNutrients.fiber!.quantity! / Double(servings)) + trendingResult.recipe.totalNutrients.fiber!.unit!
            fiberPercentLabel.text = String(format: "%.0f",trendingResult.recipe.totalDaily.fiber!.quantity! / Double(servings)) + trendingResult.recipe.totalDaily.fiber!.unit!

            sugarsGramsLabel.text = "Sugars: " + String(format: "%.0f", trendingResult.recipe.totalNutrients.sugars!.quantity! / Double(servings)) + trendingResult.recipe.totalNutrients.sugars!.unit!
            if(trendingResult.recipe.totalDaily.sugars == nil){
                sugarsPercentLabel.text = "0%"
            }
            else{
                sugarsPercentLabel.text = String(format: "%.0f",trendingResult.recipe.totalDaily.sugars!.quantity! / Double(servings)) + trendingResult.recipe.totalDaily.sugars!.unit!
            }


            proteinGramsLabel.text = "Protein: " + String(format: "%.0f", trendingResult.recipe.totalNutrients.protein!.quantity! / Double(servings)) + trendingResult.recipe.totalNutrients.protein!.unit!
            proteinPercentLabel.text = String(format: "%.0f",trendingResult.recipe.totalDaily.protein!.quantity! / Double(servings)) + trendingResult.recipe.totalDaily.protein!.unit!

            cholestGramsLabel.text = "Cholestorol: " + String(format: "%.0f", trendingResult.recipe.totalNutrients.cholesterol!.quantity! / Double(servings)) + trendingResult.recipe.totalNutrients.cholesterol!.unit!
            cholestPercentLabel.text = String(format: "%.0f",trendingResult.recipe.totalDaily.cholesterol!.quantity! / Double(servings)) + trendingResult.recipe.totalDaily.cholesterol!.unit!

            sodiumGramsLabel.text = "Sodium: " + String(format: "%.0f", trendingResult.recipe.totalNutrients.NA!.quantity! / Double(servings)) + trendingResult.recipe.totalNutrients.NA!.unit!
            sodiumPercentLabel.text = String(format: "%.0f",trendingResult.recipe.totalDaily.NA!.quantity! / Double(servings)) + trendingResult.recipe.totalDaily.NA!.unit!

            calciumGramsLabel.text = "Calcium: " + String(format: "%.0f", trendingResult.recipe.totalNutrients.CA!.quantity! / Double(servings)) + trendingResult.recipe.totalNutrients.CA!.unit!
            calciumPercentLabel.text = String(format: "%.0f",trendingResult.recipe.totalDaily.CA!.quantity! / Double(servings)) + trendingResult.recipe.totalDaily.CA!.unit!

            magnesiumGramsLabel.text = "Magnesium: " + String(format: "%.0f", trendingResult.recipe.totalNutrients.MG!.quantity! / Double(servings)) + trendingResult.recipe.totalNutrients.MG!.unit!
            magnesiumPercentLabel.text = String(format: "%.0f",trendingResult.recipe.totalDaily.MG!.quantity! / Double(servings)) + trendingResult.recipe.totalDaily.MG!.unit!

            potassiumGramsLabel.text = "Potassium: " + String(format: "%.0f", trendingResult.recipe.totalNutrients.K!.quantity! / Double(servings)) + trendingResult.recipe.totalNutrients.K!.unit!
            potassiumPercentLabel.text = String(format: "%.0f",trendingResult.recipe.totalDaily.K!.quantity! / Double(servings)) + trendingResult.recipe.totalDaily.K!.unit!

            ironGramsLabel.text = "Iron: " + String(format: "%.0f", trendingResult.recipe.totalNutrients.FE!.quantity! / Double(servings)) + trendingResult.recipe.totalNutrients.FE!.unit!
            ironPercentLabel.text = String(format: "%.0f",trendingResult.recipe.totalDaily.FE!.quantity! / Double(servings)) + trendingResult.recipe.totalDaily.FE!.unit!

            zincGramsLabel.text = "Zinc: " + String(format: "%.0f", trendingResult.recipe.totalNutrients.ZN!.quantity! / Double(servings)) + trendingResult.recipe.totalNutrients.ZN!.unit!
            zincPercentLabel.text = String(format: "%.0f",trendingResult.recipe.totalDaily.ZN!.quantity! / Double(servings)) + trendingResult.recipe.totalDaily.ZN!.unit!

            phosphorousGramsLabel.text = "Phosphorous: " + String(format: "%.0f", trendingResult.recipe.totalNutrients.P!.quantity! / Double(servings)) + trendingResult.recipe.totalNutrients.P!.unit!
            phosphorousPercentLabel.text = String(format: "%.0f",trendingResult.recipe.totalDaily.P!.quantity! / Double(servings)) + trendingResult.recipe.totalDaily.P!.unit!

            vitAGramsLabel.text = "Vitamin A: " + String(format: "%.0f", trendingResult.recipe.totalNutrients.vitaminA!.quantity! / Double(servings)) + trendingResult.recipe.totalNutrients.vitaminA!.unit!
            vitAPercentLabel.text = String(format: "%.0f",trendingResult.recipe.totalDaily.vitaminA!.quantity! / Double(servings)) + trendingResult.recipe.totalDaily.vitaminA!.unit!

            vitCGramsLabel.text = "Vitamin C: " + String(format: "%.0f", trendingResult.recipe.totalNutrients.vitaminC!.quantity! / Double(servings)) + trendingResult.recipe.totalNutrients.vitaminC!.unit!
            vitCPercentLabel.text = String(format: "%.0f",trendingResult.recipe.totalDaily.vitaminC!.quantity! / Double(servings)) + trendingResult.recipe.totalDaily.vitaminC!.unit!

            thiaminGramsLabel.text = "Thiamin: " + String(format: "%.0f", trendingResult.recipe.totalNutrients.thiamin!.quantity! / Double(servings)) + trendingResult.recipe.totalNutrients.thiamin!.unit!
            thiaminPercentLabel.text = String(format: "%.0f",trendingResult.recipe.totalDaily.thiamin!.quantity! / Double(servings)) + trendingResult.recipe.totalDaily.thiamin!.unit!

            niacinGramsLabel.text = "Niacin: " + String(format: "%.0f", trendingResult.recipe.totalNutrients.niacin!.quantity! / Double(servings)) + trendingResult.recipe.totalNutrients.niacin!.unit!
            niacinPercentLabel.text = String(format: "%.0f",trendingResult.recipe.totalDaily.niacin!.quantity! / Double(servings)) + trendingResult.recipe.totalDaily.niacin!.unit!

            vitB6GramsLabel.text = "Vitamin B6: " + String(format: "%.0f", trendingResult.recipe.totalNutrients.vitaminB6!.quantity! / Double(servings)) + trendingResult.recipe.totalNutrients.vitaminB6!.unit!
            vitB6PercentLabel.text = String(format: "%.0f",trendingResult.recipe.totalDaily.vitaminB6!.quantity! / Double(servings)) + trendingResult.recipe.totalDaily.vitaminB6!.unit!

            vitB12GramsLabel.text = "VitaminB12: " + String(format: "%.0f", trendingResult.recipe.totalNutrients.vitaminB12!.quantity! / Double(servings)) + trendingResult.recipe.totalNutrients.vitaminB12!.unit!
            vitB12PercentLabel.text = String(format: "%.0f",trendingResult.recipe.totalDaily.vitaminB12!.quantity! / Double(servings)) + trendingResult.recipe.totalDaily.vitaminB12!.unit!

            vitKGramsLabel.text = "Vitamin K: " + String(format: "%.0f", trendingResult.recipe.totalNutrients.vitaminK!.quantity! / Double(servings)) + trendingResult.recipe.totalNutrients.vitaminK!.unit!
            vitKPercentLabel.text = String(format: "%.0f",trendingResult.recipe.totalDaily.vitaminK!.quantity! / Double(servings)) + trendingResult.recipe.totalDaily.vitaminK!.unit!
        }
        else if(recommendationResult != nil){
            let servings = recommendationResult.recipe.yield!
            let calories = recommendationResult.recipe.calories! / Double(recommendationResult.recipe.yield!)

            dailyValueLabel.text = String(format: "%.0f", recommendationResult.recipe.totalDaily.kcals!.quantity! / Double(servings)) + "%"
            servingsLabel.text = String(format: "%.0f", servings)
            caloriesLabel.text = String(format: "%.0f", calories)
            kcalsLabel.text = String (format: "%.0f", (recommendationResult.recipe.totalNutrients.kcals!.quantity! / Double(servings)))
            
            fatGramsLabel.text = "Fat: " + String(format: "%.0f", recommendationResult.recipe.totalNutrients.fat!.quantity! / Double(servings)) + recommendationResult.recipe.totalNutrients.fat!.unit!
            fatPercentLabel.text = String(format: "%.0f",recommendationResult.recipe.totalDaily.fat!.quantity! / Double(servings)) + recommendationResult.recipe.totalDaily.fat!.unit!
            
            satFatGramsLabel.text = "Saturated: " + String(format: "%.0f", recommendationResult.recipe.totalNutrients.satFat!.quantity! / Double(servings)) + recommendationResult.recipe.totalNutrients.satFat!.unit!
            satFatPercentLabel.text = String(format: "%.0f",recommendationResult.recipe.totalDaily.satFat!.quantity! / Double(servings)) + recommendationResult.recipe.totalDaily.satFat!.unit!
            
            satFatGramsLabel.text = "Saturated: " + String(format: "%.0f", recommendationResult.recipe.totalNutrients.satFat!.quantity! / Double(servings)) + recommendationResult.recipe.totalNutrients.satFat!.unit!
            satFatPercentLabel.text = String()
            
            if(recommendationResult.recipe.totalNutrients.transFat == nil){
                transFatGramsLabel.text = "Trans: 0g"
            }
            else{
                transFatGramsLabel.text = "Trans: " + String(format: "%.0f", recommendationResult.recipe.totalNutrients.transFat!.quantity! / Double(servings)) + recommendationResult.recipe.totalNutrients.transFat!.unit!
            }
            if(recommendationResult.recipe.totalDaily.transFat == nil )
            {
                transFatPercentLabel.text = "0%"
            }
            else{
                transFatPercentLabel.text = String(format: "%.0f",(recommendationResult.recipe.totalDaily.transFat!.quantity! ) / Double(servings)) + recommendationResult.recipe.totalDaily.transFat!.unit!
            }
            
            if(recommendationResult.recipe.totalNutrients.monoFat == nil){
                monoSatGramsLabel.text = "Monounsaturated: 0g"
            }
            else{
                monoSatGramsLabel.text = "Monounsaturated: " + String(format: "%.0f", recommendationResult.recipe.totalNutrients.monoFat!.quantity! / Double(servings)) + recommendationResult.recipe.totalNutrients.monoFat!.unit!
            }
            if(recommendationResult.recipe.totalDaily.monoFat == nil){
                monoSatPercentLabel.text = "0%"
            }
            else{
                monoSatPercentLabel.text = String(format: "%.0f",recommendationResult.recipe.totalDaily.monoFat!.quantity! / Double(servings)) + recommendationResult.recipe.totalDaily.monoFat!.unit!
            }
            if(recommendationResult.recipe.totalNutrients.polyunFat == nil){
                polySatGramsLabel.text = "Polyunsaturated: 0g"
            }
            else{
                polySatGramsLabel.text = "Polyunsaturated: " + String(format: "%.0f", recommendationResult.recipe.totalNutrients.polyunFat!.quantity! / Double(servings)) + recommendationResult.recipe.totalNutrients.polyunFat!.unit!
            }
            if(recommendationResult.recipe.totalDaily.polyunFat == nil){
                polySatPercentLabel.text = "0%"
            }
            else{
                polySatPercentLabel.text = String(format: "%.0f",recommendationResult.recipe.totalDaily.polyunFat!.quantity! / Double(servings)) + recommendationResult.recipe.totalDaily.polyunFat!.unit!
            }


            carboGramsLabel.text = "Carbohydrates: " + String(format: "%.0f", recommendationResult.recipe.totalNutrients.carbs!.quantity! / Double(servings)) + recommendationResult.recipe.totalNutrients.carbs!.unit!
            carboPercentLabel.text = String(format: "%.0f",recommendationResult.recipe.totalDaily.carbs!.quantity! / Double(servings)) + recommendationResult.recipe.totalDaily.carbs!.unit!

            fiberGramsLabel.text = "Dietary Fiber: " + String(format: "%.0f", recommendationResult.recipe.totalNutrients.fiber!.quantity! / Double(servings)) + recommendationResult.recipe.totalNutrients.fiber!.unit!
            fiberPercentLabel.text = String(format: "%.0f",recommendationResult.recipe.totalDaily.fiber!.quantity! / Double(servings)) + recommendationResult.recipe.totalDaily.fiber!.unit!

            sugarsGramsLabel.text = "Sugars: " + String(format: "%.0f", recommendationResult.recipe.totalNutrients.sugars!.quantity! / Double(servings)) + recommendationResult.recipe.totalNutrients.sugars!.unit!
            if(recommendationResult.recipe.totalDaily.sugars == nil){
                sugarsPercentLabel.text = "0%"
            }
            else{
                sugarsPercentLabel.text = String(format: "%.0f",recommendationResult.recipe.totalDaily.sugars!.quantity! / Double(servings)) + recommendationResult.recipe.totalDaily.sugars!.unit!
            }


            proteinGramsLabel.text = "Protein: " + String(format: "%.0f", recommendationResult.recipe.totalNutrients.protein!.quantity! / Double(servings)) + recommendationResult.recipe.totalNutrients.protein!.unit!
            proteinPercentLabel.text = String(format: "%.0f",recommendationResult.recipe.totalDaily.protein!.quantity! / Double(servings)) + recommendationResult.recipe.totalDaily.protein!.unit!

            cholestGramsLabel.text = "Cholestorol: " + String(format: "%.0f", recommendationResult.recipe.totalNutrients.cholesterol!.quantity! / Double(servings)) + recommendationResult.recipe.totalNutrients.cholesterol!.unit!
            cholestPercentLabel.text = String(format: "%.0f",recommendationResult.recipe.totalDaily.cholesterol!.quantity! / Double(servings)) + recommendationResult.recipe.totalDaily.cholesterol!.unit!

            sodiumGramsLabel.text = "Sodium: " + String(format: "%.0f", recommendationResult.recipe.totalNutrients.NA!.quantity! / Double(servings)) + recommendationResult.recipe.totalNutrients.NA!.unit!
            sodiumPercentLabel.text = String(format: "%.0f",recommendationResult.recipe.totalDaily.NA!.quantity! / Double(servings)) + recommendationResult.recipe.totalDaily.NA!.unit!

            calciumGramsLabel.text = "Calcium: " + String(format: "%.0f", recommendationResult.recipe.totalNutrients.CA!.quantity! / Double(servings)) + recommendationResult.recipe.totalNutrients.CA!.unit!
            calciumPercentLabel.text = String(format: "%.0f",recommendationResult.recipe.totalDaily.CA!.quantity! / Double(servings)) + recommendationResult.recipe.totalDaily.CA!.unit!

            magnesiumGramsLabel.text = "Magnesium: " + String(format: "%.0f", recommendationResult.recipe.totalNutrients.MG!.quantity! / Double(servings)) + recommendationResult.recipe.totalNutrients.MG!.unit!
            magnesiumPercentLabel.text = String(format: "%.0f",recommendationResult.recipe.totalDaily.MG!.quantity! / Double(servings)) + recommendationResult.recipe.totalDaily.MG!.unit!

            potassiumGramsLabel.text = "Potassium: " + String(format: "%.0f", recommendationResult.recipe.totalNutrients.K!.quantity! / Double(servings)) + recommendationResult.recipe.totalNutrients.K!.unit!
            potassiumPercentLabel.text = String(format: "%.0f",recommendationResult.recipe.totalDaily.K!.quantity! / Double(servings)) + recommendationResult.recipe.totalDaily.K!.unit!

            ironGramsLabel.text = "Iron: " + String(format: "%.0f", recommendationResult.recipe.totalNutrients.FE!.quantity! / Double(servings)) + recommendationResult.recipe.totalNutrients.FE!.unit!
            ironPercentLabel.text = String(format: "%.0f",recommendationResult.recipe.totalDaily.FE!.quantity! / Double(servings)) + recommendationResult.recipe.totalDaily.FE!.unit!

            zincGramsLabel.text = "Zinc: " + String(format: "%.0f", recommendationResult.recipe.totalNutrients.ZN!.quantity! / Double(servings)) + recommendationResult.recipe.totalNutrients.ZN!.unit!
            zincPercentLabel.text = String(format: "%.0f",recommendationResult.recipe.totalDaily.ZN!.quantity! / Double(servings)) + recommendationResult.recipe.totalDaily.ZN!.unit!

            phosphorousGramsLabel.text = "Phosphorous: " + String(format: "%.0f", recommendationResult.recipe.totalNutrients.P!.quantity! / Double(servings)) + recommendationResult.recipe.totalNutrients.P!.unit!
            phosphorousPercentLabel.text = String(format: "%.0f",recommendationResult.recipe.totalDaily.P!.quantity! / Double(servings)) + recommendationResult.recipe.totalDaily.P!.unit!

            vitAGramsLabel.text = "Vitamin A: " + String(format: "%.0f", recommendationResult.recipe.totalNutrients.vitaminA!.quantity! / Double(servings)) + recommendationResult.recipe.totalNutrients.vitaminA!.unit!
            vitAPercentLabel.text = String(format: "%.0f",recommendationResult.recipe.totalDaily.vitaminA!.quantity! / Double(servings)) + recommendationResult.recipe.totalDaily.vitaminA!.unit!

            vitCGramsLabel.text = "Vitamin C: " + String(format: "%.0f", recommendationResult.recipe.totalNutrients.vitaminC!.quantity! / Double(servings)) + recommendationResult.recipe.totalNutrients.vitaminC!.unit!
            vitCPercentLabel.text = String(format: "%.0f",recommendationResult.recipe.totalDaily.vitaminC!.quantity! / Double(servings)) + recommendationResult.recipe.totalDaily.vitaminC!.unit!

            thiaminGramsLabel.text = "Thiamin: " + String(format: "%.0f", recommendationResult.recipe.totalNutrients.thiamin!.quantity! / Double(servings)) + recommendationResult.recipe.totalNutrients.thiamin!.unit!
            thiaminPercentLabel.text = String(format: "%.0f",recommendationResult.recipe.totalDaily.thiamin!.quantity! / Double(servings)) + recommendationResult.recipe.totalDaily.thiamin!.unit!

            niacinGramsLabel.text = "Niacin: " + String(format: "%.0f", recommendationResult.recipe.totalNutrients.niacin!.quantity! / Double(servings)) + recommendationResult.recipe.totalNutrients.niacin!.unit!
            niacinPercentLabel.text = String(format: "%.0f",recommendationResult.recipe.totalDaily.niacin!.quantity! / Double(servings)) + recommendationResult.recipe.totalDaily.niacin!.unit!

            vitB6GramsLabel.text = "Vitamin B6: " + String(format: "%.0f", recommendationResult.recipe.totalNutrients.vitaminB6!.quantity! / Double(servings)) + recommendationResult.recipe.totalNutrients.vitaminB6!.unit!
            vitB6PercentLabel.text = String(format: "%.0f",recommendationResult.recipe.totalDaily.vitaminB6!.quantity! / Double(servings)) + recommendationResult.recipe.totalDaily.vitaminB6!.unit!

            vitB12GramsLabel.text = "VitaminB12: " + String(format: "%.0f", recommendationResult.recipe.totalNutrients.vitaminB12!.quantity! / Double(servings)) + recommendationResult.recipe.totalNutrients.vitaminB12!.unit!
            vitB12PercentLabel.text = String(format: "%.0f",recommendationResult.recipe.totalDaily.vitaminB12!.quantity! / Double(servings)) + recommendationResult.recipe.totalDaily.vitaminB12!.unit!

            vitKGramsLabel.text = "Vitamin K: " + String(format: "%.0f", recommendationResult.recipe.totalNutrients.vitaminK!.quantity! / Double(servings)) + recommendationResult.recipe.totalNutrients.vitaminK!.unit!
            vitKPercentLabel.text = String(format: "%.0f",recommendationResult.recipe.totalDaily.vitaminK!.quantity! / Double(servings)) + recommendationResult.recipe.totalDaily.vitaminK!.unit!
        }
    }
}
extension NutrientsViewController: UIViewControllerTransitioningDelegate {
  func animationController(
    forPresented presented: UIViewController,
    presenting: UIViewController,
    source: UIViewController
  ) -> UIViewControllerAnimatedTransitioning? {
    return BounceAnimationController()
  }
}
