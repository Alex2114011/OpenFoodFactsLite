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
    func setState(stateIs: ListPresenter.State)
}

protocol ListViewPresenterProtocol: AnyObject {
    init(view: ListViewProtocol, router: RouterProtocol, networkBuilder: NetworkBuilderProtocol)
    func getProductSearch(searchText: String)
    func getNextProductSearch()
    func goToDetail(barCode: String)
    var productsModel: [Product] {get set}
    var productOFBarCode: BarCode? {get set}
    var searchText: String {get set}
}

final class ListPresenter: ListViewPresenterProtocol {

    weak var view: ListViewProtocol?
    var router: RouterProtocol?
    var networkBuilder: NetworkBuilderProtocol?
    var productsModel: [Product] = []
    var productOFBarCode: BarCode?
    private var pageCount = 1
    var searchText: String = ""

    required init(view: ListViewProtocol, router: RouterProtocol, networkBuilder: NetworkBuilderProtocol) {
        self.view = view
        self.router = router
        self.networkBuilder = networkBuilder
    }

    enum State {
        case initial(Bool)
        case loading(Bool)
        case empty(Bool)
    }

    

    func getProductSearch(searchText: String) {
        guard let networkBuilder = networkBuilder else { return }
        let service = networkBuilder.createSearchService()
        self.pageCount = 1
        self.view?.setState(stateIs: .loading(true))
        service.getSearchProduct(searchText: searchText, page: pageCount) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let data):
                if data.count != 0 {
                    self.productsModel = []
                    data.products?.forEach({ product in
                        self.productsModel.append(product)
                        self.view?.success()
                        self.view?.setState(stateIs: .loading(false))
                    })
                } else {
                    self.view?.setState(stateIs: .empty(true))
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    func getNextProductSearch() {
        guard let networkBuilder = networkBuilder else { return }
        let service = networkBuilder.createSearchService()
        service.getSearchProduct(searchText: searchText, page: pageCount + 1 ) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let data):
                data.products?.forEach({ product in
                    self.productsModel.append(product)
                    self.view?.success()
                })
                self.pageCount += 1
                print("PAGECOUNT\(self.pageCount)")
            case .failure(let error):
                print(error)
            }
        }
    }

func goToDetail(barCode: String) {
    router?.showDetail(barCode: barCode)
}
}
