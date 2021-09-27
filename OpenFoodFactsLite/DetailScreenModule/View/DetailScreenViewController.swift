//
//  DetailScreenViewController.swift
//  OpenFoodFactsLite
//
//  Created by Alex on 08.09.2021.
//

import UIKit

class DetailScreenViewController: UIViewController {
    var detailTableView = UITableView()
    var presenter: DetailPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupTable()
        guard let presenter = presenter else { return }
        presenter.getProductBarCode(searchText: presenter.barCode )
        presenter.presented(true)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter?.presented(false)
    }
    private func setupTable() {
        // Delegate
        detailTableView.dataSource = self
        detailTableView.delegate = self
        // SetupUI Table
        view.addSubview(detailTableView)
        detailTableView.translatesAutoresizingMaskIntoConstraints = false
        detailTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        detailTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        detailTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        detailTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        // Register cell
        detailTableView.register(cell: SummaryTableViewCell.self)
        detailTableView.register(cell: AnaliticsIngridientsTableViewCell.self)
        detailTableView.register(cell: NutritionalTableViewCell.self)
        detailTableView.register(cell: BarCodeTableViewCell.self)
    }
}

extension DetailScreenViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let productOFBarCode = presenter?.productOFBarCode else { return UITableViewCell()}
        if indexPath.section == 0 {
            let cell = tableView.getCell(SummaryTableViewCell.self, indexPath)
            let item = productOFBarCode
            cell.updateUI(model: item)
            return cell
        }
        if indexPath.section == 1 {
            let cell = tableView.getCell(AnaliticsIngridientsTableViewCell.self, indexPath)
            let item = productOFBarCode
            cell.updateUI(model: item)
            return cell
        }
        if indexPath.section == 2 {
            let cell = tableView.getCell(NutritionalTableViewCell.self, indexPath)
            let item = productOFBarCode
            cell.updateUI(model: item)
            return cell
        }
        if indexPath.section == 3 {
            let cell = tableView.getCell(BarCodeTableViewCell.self, indexPath)
            let item = productOFBarCode
            cell.updateUI(model: item)
            return cell
        }
    return UITableViewCell()
    }
}

extension DetailScreenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return 115
        case 1: return 210
        case 2: return 240
        case 3: return 50
        default:
            return 100
        }
    }
}

extension DetailScreenViewController: DetailViewProtocol {

    func setState(stateIs: DetailPresenter.State) {
        switch stateIs {
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
        detailTableView.reloadData()
    }

    func failure(error: Error) {
    }
}
