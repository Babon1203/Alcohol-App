//
//  CollectionViewController.swift
//  AlcoholApp
//
//  Created by Кирилл Саталкин on 10.11.2023.
//

import UIKit


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
    
    private let networkManager = NetworkManager.shared
    private var drinks: [Drink] = []

    override func viewDidLoad() {
        super.viewDidLoad()
       InfoCoctail()

    }
    private func InfoCoctail() {
        networkManager.Info(DrinkList.self, from: url) { [unowned self] result in
            switch result {
            case .success(let coctail):
                print(coctail)
                showAlert(withStatus: .success)
            case .failure(_):
                showAlert(withStatus: .failed)
            }
        }
    }

    
    private func showAlert(withStatus status: Alert) {
        let alert = UIAlertController(title: status.title, message: status.message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    override func prepare(for segue:UIStoryboardSegue, sender:Any?) {
        if segue.identifier == "showSegue" {
            guard segue.destination is infoViewController else { return }
            
        }
    }
}

extension MainViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        drinks.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pressedLabel", for: indexPath) as? LabelViewCell else {
            return UICollectionViewCell()
        }
        
        let drink = drinks[indexPath.item]
        cell.pressLabel.text = drink.strDrink
        
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 48, height: 50)
    }
}


