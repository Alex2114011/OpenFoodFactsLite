//
//  MainScreenViewController.swift
//  OpenFoodFactsLite
//
//  Created by Alex on 27.08.2021.
//

import UIKit

class MainScreenViewController: UIViewController {

  private lazy var searchController = UISearchController()

    @IBOutlet private weak var logoImageView: UIImageView!

    var presenter: MainViewPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupSearchController()
    }

    private func setupSearchController() {
        searchController.searchBar.placeholder = "Поиск по названию или штрихкоду"
        searchController.searchBar.delegate = self
        searchController.searchBar.backgroundColor = .white
        searchController.obscuresBackgroundDuringPresentation = false
    }

    private func setupUI() {
        navigationItem.title = "Поиск"
        navigationItem.searchController = searchController
        view.backgroundColor = .white
        logoImageView.image = UIImage(named: "openfoodfacts-logo-en")
        let tabBarItem = UITabBarItem(title: "Поиск",
                                      image: UIImage(systemName: "magnifyingglass"),
                                      tag: 0)
        self.tabBarItem = tabBarItem
    }
}

extension MainScreenViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let inputText = searchBar.text else { return }

        if Int(inputText) != nil {
            presenter.getProductBarCode(searchText: inputText)
        } else {
            presenter.getProductSearch(searchText: inputText, page: 0)
        }
    }
}

extension MainScreenViewController: MainViewProtocol {
    func success() {

    }

    func fail(error: Error) {

    }
}
