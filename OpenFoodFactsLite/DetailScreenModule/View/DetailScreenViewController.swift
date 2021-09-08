//
//  DetailScreenViewController.swift
//  OpenFoodFactsLite
//
//  Created by Alex on 08.09.2021.
//

import UIKit

class DetailScreenViewController: UIViewController {

    var presenter: DetailPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
}

extension DetailScreenViewController: DetailViewProtocol {
}
