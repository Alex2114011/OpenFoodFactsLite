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
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)

}

class MainPresenter: MainViewPresenterProtocol {

    weak var view: MainViewProtocol?
    var networkService: NetworkServiceProtocol!
    let router: RouterProtocol?

    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
    }
}
