//
//  ListScreenViewController.swift
//  OpenFoodFactsLite
//
//  Created by Alex on 29.08.2021.
//

import UIKit

final class ListScreenViewController: UIViewController {

    private var searchController = UISearchController()
    private var listTableView = UITableView()

    var presenter: ListViewPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupSearchController()
        setupTable()
        setState(stateIs: .initial(true))
    }

    private func setupSearchController() {
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Поиск по названию или штрихкоду"
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
    }

    private func setupUI() {
        let tabBarItem = UITabBarItem(title: "Поиск",
                                      image: UIImage(systemName: "magnifyingglass"),
                                      tag: 0)
        self.tabBarItem = tabBarItem
        navigationItem.title = "Поиск"
        navigationItem.searchController = searchController

        view.backgroundColor = .white
    }

    private func setupTable() {
        // Delegate
        listTableView.dataSource = self
        listTableView.delegate = self
        // SetupUI Table
        view.addSubview(listTableView)
        listTableView.translatesAutoresizingMaskIntoConstraints = false
        listTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        listTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        listTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        listTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        // Register cell
        listTableView.register(cell: ListTableViewCell.self)
        listTableView.alwaysBounceVertical = false
    }
}

extension ListScreenViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        guard let inputText = searchBar.text else { return }
        presenter.searchText = inputText

        if Int(presenter.searchText) != nil {
            presenter.goToDetail(barCode: inputText, delegate: nil)
        } else {
            presenter.getProductSearch(searchText: inputText)
            setState(stateIs: .initial(false))

        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter.productsModel = []
        listTableView.reloadData()
        setState(stateIs: .initial(true))
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if searchBar.text != nil {
            searchBar.text = ""
            self.setState(stateIs: .initial(false))
            self.setState(stateIs: .initial(true))
            self.setState(stateIs: .empty(false))
            self.setState(stateIs: .loading(false))
        }
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
        cell.selectionStyle = .none
        cell.updateUI(model: item)
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row - 1 >= presenter.productsModel.count - 2 {
            presenter.getNextProductSearch()
        }
    }
}

extension ListScreenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let barCode = presenter.productsModel[indexPath.row].code else {return}
        presenter.goToDetail(barCode: barCode, delegate: nil)
    }
}

extension ListScreenViewController: ListViewProtocol {
    func setState(stateIs: ListPresenter.State) {
        switch stateIs {
        case .initial(let setOn):
            if setOn {
                self.addInitialView()
            } else {
                self.removeInitialView()
            }
        case .loading(let setOn):
            if setOn {
                self.activityStartAnimating(activityColor: .gray, backgroundColor: .white)
            } else {
                self.activityStopAnimating()
            }
        case .empty(let setOn):
            if setOn {
                self.addEmptyView()
            } else {
                self.removeEmptyView()
            }
        }
    }

    func success() {
        listTableView.reloadData()
    }

    func fail(error: Error) {
    }

}
