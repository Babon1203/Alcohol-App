//
//  infoViewController.swift
//  AlcoholApp
//
//  Created by Кирилл Саталкин on 10.11.2023.
//

import UIKit
import Alamofire



final class infoViewController: UITableViewController {
   
    var url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Alcoholic")!

    private var drinks: [Drink] = []
 
    private let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 100
        fetchDrink()
    }
    
    private func fetchDrink() {
        networkManager.fetchCoctail(from: url) { result in
            switch result {
            case .success(let drinks):
                
                self.drinks = drinks
                self.tableView.reloadData()
                print(drinks)
            case .failure(let error):
                print(error)
            }
        }
        }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        drinks.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        guard let cell = cell as? TableViewCell else { return UITableViewCell() }
        let drink = drinks[indexPath.row]
        cell.configure(with: drink)
        
        cell.layer.borderWidth = 10
        cell.layer.borderColor = UIColor.white.cgColor
        
        return cell
    }
}
