//
//  ScanPresenter.swift
//  OpenFoodFactsLite
//
//  Created by Alex on 21.09.2021.
//

import Foundation

protocol ScanViewProtocol: AnyObject {

}

protocol ScanViewPresenterProtocol: AnyObject {
    init(view: ScanViewProtocol, router: RouterProtocol)
    func goToDetailModal(barCode: String)
    func popToRoot()
}

class ScanViewPresenter: ScanViewPresenterProtocol {

    weak var view: ScanViewProtocol?
    var router: RouterProtocol?

    required init(view: ScanViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }

    func goToDetailModal(barCode: String) {
        router?.showDetailModal(barCode: barCode)
    }
    func popToRoot() {
        router?.popToRoot()
    }
}
