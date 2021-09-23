//
//  DetailPresenter.swift
//  OpenFoodFactsLite
//
//  Created by Alex on 08.09.2021.
//

import Foundation
protocol DetailPresenterDelegate: AnyObject {
    func detailViewControllerIs(presented: Bool)
}

protocol DetailViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
    func setState(stateIs: DetailPresenter.State)
}

protocol DetailViewPresenterProtocol: AnyObject {
    init(view: DetailViewProtocol,
         router: RouterProtocol,
         networkBuilder: NetworkBuilderProtocol,
         barCode: String,
         delegate: DetailPresenterDelegate?)
    func getProductBarCode(searchText: String)
    func presented(_ presented: Bool)
}

class DetailPresenter: DetailViewPresenterProtocol {

    weak var view: DetailViewProtocol?
    weak var delegate: DetailPresenterDelegate?
    let router: RouterProtocol?
    let networkBuilder: NetworkBuilderProtocol?
    let barCode: String

    var productOFBarCode: BarCode?

    required init(view: DetailViewProtocol,
                  router: RouterProtocol,
                  networkBuilder: NetworkBuilderProtocol,
                  barCode: String,
                  delegate: DetailPresenterDelegate?) {
        self.view = view
        self.router = router
        self.networkBuilder = networkBuilder
        self.barCode = barCode
        self.delegate = delegate
    }

    enum State {
        case loading(Bool)
        case empty(Bool)
    }

    func getProductBarCode(searchText: String) {
        guard let networkBuilder = networkBuilder else { return }
        let service = networkBuilder.createSearchService()
        self.view?.setState(stateIs: .empty(false))
        self.view?.setState(stateIs: .loading(true))
        service.getBarCodeProduct(searchText: searchText) {[weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let data):
                if data.statusVerbose == "product found" {
                self.productOFBarCode = nil
                self.productOFBarCode = data
                print(data.statusVerbose as Any)
                self.view?.success()
                self.view?.setState(stateIs: .loading(false))
                } else {
                    self.view?.setState(stateIs: .empty(true))
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    func presented(_ presented: Bool) {
        delegate?.detailViewControllerIs(presented: presented)
    }
}
