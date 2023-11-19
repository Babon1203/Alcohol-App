//
//  TableViewCell.swift
//  AlcoholApp
//
//  Created by Кирилл Саталкин on 14.11.2023.
//

import UIKit

final class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageCoctail: UIImageView!
    @IBOutlet weak var idCoctail: UILabel!
    @IBOutlet weak var nameCoctail: UILabel!
    
    private let networkManager = NetworkManager.shared
    
    func configure(with drink: Drink) {
        nameCoctail.text = "Название коктеля: \n \(drink.strDrink)"
        idCoctail.text = "ID коктеля:  \(drink.idDrink)"
        
        networkManager.fetchData(from: drink.strDrinkThumb) { result in
            switch result {
                
            case .success(let imageData):
                self.imageCoctail.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
        
    }
}

