//
//  ListScreenViewController.swift
//  OpenFoodFactsLite
//
//  Created by Alex on 29.08.2021.
//

import UIKit

class ListScreenViewController: UIViewController {

    @IBOutlet weak var listTableView: UITableView!

    var presenter: ListViewPresenterProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension ListScreenViewController: ListViewProtocol {
}
