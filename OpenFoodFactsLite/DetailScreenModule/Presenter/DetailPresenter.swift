//
//  DetailPresenter.swift
//  OpenFoodFactsLite
//
//  Created by Alex on 08.09.2021.
//

import Foundation

protocol DetailViewProtocol: AnyObject {
}

protocol DetailViewPresenterProtocol: AnyObject {
    init(view: DetailViewProtocol,
         router: RouterProtocol,
         productOFBarCode: BarCode)
}

class DetailPresenter: DetailViewPresenterProtocol {

    weak var view: DetailViewProtocol?
    let router: RouterProtocol?
    var productOFBarCode: BarCode

    required init(view: DetailViewProtocol,
                  router: RouterProtocol,
                  productOFBarCode: BarCode) {
        self.view = view
        self.router = router
        self.productOFBarCode = productOFBarCode
    }
}
