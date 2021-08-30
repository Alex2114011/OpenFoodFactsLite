//
//  MainPresenter.swift
//  OpenFoodFactsLite
//
//  Created by Alex on 27.08.2021.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    func success()
    func fail(error: Error)
}

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, networkBuilder: NetworkBuilderProtocol, router: RouterProtocol)
    func getProductBarCode(searchText: String)
    func getProductSearch(searchText: String, page: Int)
}

class MainPresenter: MainViewPresenterProtocol {

    weak var view: MainViewProtocol!
    var networkBuilder: NetworkBuilderProtocol!
    var router: RouterProtocol?

    required init(view: MainViewProtocol, networkBuilder: NetworkBuilderProtocol, router: RouterProtocol) {
        self.view = view
        self.networkBuilder = networkBuilder
        self.router = router
    }

    func getProductBarCode(searchText: String) {
        let service = networkBuilder.createSearchService()
        service.getBarCodeProduct(searchText: searchText) { result in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }

    func getProductSearch(searchText: String, page: Int) {
        let service = networkBuilder.createSearchService()
        service.getSearchProduct(searchText: searchText, page: page) { result in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }

}
