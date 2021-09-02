//
//  ListPresenter.swift
//  OpenFoodFactsLite
//
//  Created by Alex on 29.08.2021.
//

import Foundation

protocol ListViewProtocol: AnyObject {
    func success()
    func fail(error: Error)
}

protocol ListViewPresenterProtocol: AnyObject {
    init(view: ListViewProtocol, router: RouterProtocol, networkBuilder: NetworkBuilderProtocol)
    func getProductBarCode(searchText: String)
    func getProductSearch(searchText: String, page: Int)
    var productsModel: [Product] {get set}
    var productOFBarCode: [BarCode] {get set}
}

final class ListPresenter: ListViewPresenterProtocol {
    weak var view: ListViewProtocol?
    var router: RouterProtocol?
    var networkBuilder: NetworkBuilderProtocol?
    var productsModel: [Product] = []
    var productOFBarCode: [BarCode] = []

    required init(view: ListViewProtocol, router: RouterProtocol, networkBuilder: NetworkBuilderProtocol) {
        self.view = view
        self.router = router
        self.networkBuilder = networkBuilder
    }

    func getProductBarCode(searchText: String) {
        guard let networkBuilder = networkBuilder else { return }
        let service = networkBuilder.createSearchService()
        service.getBarCodeProduct(searchText: searchText) {[weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let data):
                self.productOFBarCode = []
                self.productOFBarCode = [data]
                    self.view?.success()
                print(self.productsModel)
            case .failure(let error):
                print(error)
            }
        }
    }

    func getProductSearch(searchText: String, page: Int) {
        guard let networkBuilder = networkBuilder else { return }
        let service = networkBuilder.createSearchService()
        service.getSearchProduct(searchText: searchText, page: page) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let data):
                self.productsModel = []
                data.products?.forEach({ product in
                    self.productsModel.append(product)
                    self.view?.success()
                })
                print(self.productsModel)
            case .failure(let error):
                print(error)
            }
        }
    }
}
