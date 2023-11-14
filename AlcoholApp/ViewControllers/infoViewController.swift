//
//  infoViewController.swift
//  AlcoholApp
//
//  Created by Кирилл Саталкин on 10.11.2023.
//

import UIKit

final class infoViewController: UITableViewController {
    
    private var drinks: [Drink] = []
    
    
    //private let networkManager = NetworkManager.shared
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        drinks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        guard let cell = cell as? TableViewCell else { return UITableViewCell() }
        
        let drink = drinks[indexPath.row]
        cell.nameCoctail.text = drink.strDrink
        cell.idCoctail.text = drink.idDrink
        

        return cell
    }

}

// MARK: - Networking
extension infoViewController {
    func coctails() {
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data else {
                print(error as Any)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                self?.drinks = try decoder.decode([Drink].self, from: data)
                DispatchQueue.main.async {
                self?.tableView.reloadData()
                }
            } catch let error {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
}
