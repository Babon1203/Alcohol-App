//
//  Drinks.swift
//  AlcoholApp
//
//  Created by Кирилл Саталкин on 10.11.2023.
//

import Foundation
import Alamofire

struct Drink: Codable {
    let strDrink: String
    let strDrinkThumb: String
    let idDrink: String
    
    init(strDrink: String, strDrinkThumb: String, idDrink: String) {
        self.strDrink = strDrink
        self.strDrinkThumb = strDrinkThumb
        self.idDrink = idDrink
    }
    
    init(drinkData:[String: Any]) {
        strDrink = drinkData["strDrink"] as? String ?? ""
        strDrinkThumb = drinkData["strDrinkThumb"] as? String ?? ""
        idDrink = drinkData["idDrink"] as? String ?? ""
        
    }
    static func getCoctail(from value: Any) -> [Drink] {
        guard let drinksData = value as? [String: Any] else { return []}
         var coctail = [Drink]()

        for _ in drinksData {
            let drink = Drink(drinkData: drinksData)
            coctail.append(drink)
        }
        return coctail
        
    }
}

struct DrinkList: Codable {
    let drinks: [Drink]
   }


