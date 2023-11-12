//
//  infoViewController.swift
//  AlcoholApp
//
//  Created by Кирилл Саталкин on 10.11.2023.
//

import UIKit

class infoViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
}
