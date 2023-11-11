//
//  Drinks.swift
//  AlcoholApp
//
//  Created by Кирилл Саталкин on 10.11.2023.
//

import Foundation


struct Drink: Codable {
    let strDrink: String
    let strDrinkThumb: String
    let idDrink: String
}

struct DrinkList: Codable {
    let drinks: [Drink]
}
