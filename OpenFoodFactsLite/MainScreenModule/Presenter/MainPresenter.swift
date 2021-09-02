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
    var productsModel: [Product] {get set}
}

class MainPresenter: MainViewPresenterProtocol {

    weak var view: MainViewProtocol!
    var networkBuilder: NetworkBuilderProtocol!
    var router: RouterProtocol?
    var productsModel: [Product] = []

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
        service.getSearchProduct(searchText: searchText, page: page) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let data):
                data.products?.forEach({ product in
                    self.productsModel.append(product)
                })
                print(self.productsModel)
            case .failure(let error):
                print(error)
            }
        }
    }

}
