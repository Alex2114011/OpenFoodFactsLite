//
//  ListScreenViewController.swift
//  OpenFoodFactsLite
//
//  Created by Alex on 29.08.2021.
//

import UIKit

class ListScreenViewController: UIViewController {

    @IBOutlet private weak var logoImageView: UIImageView!
    private lazy var searchController = UISearchController()
    private var listTableView = UITableView()

    var presenter: ListViewPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupSearchController()
        setupTable()
    }

    private func setupSearchController() {
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Поиск по названию или штрихкоду"
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.automaticallyShowsSearchResultsController = false
    }

    private func setupUI() {
        let tabBarItem = UITabBarItem(title: "Поиск",
                                      image: UIImage(systemName: "magnifyingglass"),
                                      tag: 0)
        self.tabBarItem = tabBarItem
        navigationItem.title = "Поиск"
        navigationItem.searchController = searchController

        view.backgroundColor = .white
        logoImageView.image = UIImage(named: "openfoodfacts-logo-en")
    }

    private func setupTable() {
        // Delegate
        listTableView.dataSource = self
        listTableView.delegate = self
        // SetupUI Table
        listTableView.isHidden = true
        view.addSubview(listTableView)
        listTableView.translatesAutoresizingMaskIntoConstraints = false
        listTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        listTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        listTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        listTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        // Register cell
        listTableView.register(cell: ListTableViewCell.self)
    }
}
extension ListScreenViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        guard let inputText = searchBar.text else { return }
        listTableView.isHidden = false
        presenter.searchText = inputText

        if Int(presenter.searchText) != nil {
            presenter.getProductBarCode()
        } else {
            presenter.getProductSearch()
            searchController.showsSearchResultsController = true
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        listTableView.isHidden = true
        presenter.productsModel = []
        listTableView.reloadData()
    }
}

extension ListScreenViewController: UISearchControllerDelegate {

}

extension ListScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.productsModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.getCell(ListTableViewCell.self, indexPath)
        let item = presenter.productsModel[indexPath.row]
        cell.updateUI(model: item)
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        if presenter.productsModel.count >= 24 {
            if indexPath.row + 4 >= presenter.productsModel.count - 5 {
                presenter.getNextProductSearch()
            }
        }
    }
}

extension ListScreenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension ListScreenViewController: ListViewProtocol {
    func success() {
        listTableView.reloadData()
    }

    func fail(error: Error) {
    }

}

extension ListScreenViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {

    }
}
