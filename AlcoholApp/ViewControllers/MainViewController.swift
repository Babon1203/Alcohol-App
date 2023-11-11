//
//  CollectionViewController.swift
//  AlcoholApp
//
//  Created by Кирилл Саталкин on 10.11.2023.
//

import UIKit




private var url: URL = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Alcoholic")!

enum Alert {
    case success
    case failed
    
    var title: String {
        switch self {
        case .success:
            return "Success"
        case .failed:
            return "Failed"
        }
    }
    
    var message: String {
        switch self {
        case .success:
            return "You can see the results in the Debug area"
        case .failed:
            return "You can see the error in the Debug area"
        }
    }
}

final class MainViewController: UICollectionViewController {
    private var drinks = [Drink]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(LabelViewCell.self, forCellWithReuseIdentifier: "show")
        
        alcohol()
    }
    
    private func showAlert(withStatus status: Alert) {
        let alert = UIAlertController(title: status.title, message: status.message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        DispatchQueue.main.async { [unowned self] in
            present(alert, animated: true)
        }
    }
}

extension MainViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return drinks.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "show", for: indexPath) as? LabelViewCell else {
            return UICollectionViewCell()
        }
        
        let drink = drinks[indexPath.item]
        cell.pressLabel.text = drink.strDrink
        
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 48, height: 100)
    }
}

extension MainViewController {
    private func alcohol() {
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                DispatchQueue.main.async { [weak self] in
                    self?.showAlert(withStatus: .failed)
                }
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let drinkList = try jsonDecoder.decode(DrinkList.self, from: data)
                let drinks = drinkList.drinks
                DispatchQueue.main.async { [weak self] in
                    self?.showAlert(withStatus: .success)
                    self?.collectionView.reloadData()
                    print(drinks)
                }
            } catch {
                DispatchQueue.main.async { [weak self] in
                    self?.showAlert(withStatus: .failed)
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
}

