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
    var isDetailPresented: Bool { get set }
}

class ScanViewPresenter: ScanViewPresenterProtocol {

    weak var view: ScanViewProtocol?
    var router: RouterProtocol?
    var isDetailPresented = false
    required init(view: ScanViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }

    func goToDetailModal(barCode: String) {
        router?.showDetailModal(barCode: barCode, delegate: self)
    }

    func popToRoot() {
        router?.popToRoot()
    }
}

extension ScanViewPresenter: DetailPresenterDelegate {
    func detailViewControllerIs(presented: Bool) {
        self.isDetailPresented = presented
    }
}
