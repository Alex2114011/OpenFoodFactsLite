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
         networkBuilder: NetworkBuilderProtocol,
         searhModel: [Product],
         barCodeModel: [BarCode])
}

class DetailPresenter: DetailViewPresenterProtocol {

    weak var view: DetailViewProtocol?
    let router: RouterProtocol?
    let networkBuilder: NetworkBuilderProtocol?
    var searhModel: [Product] = []
    var barCodeModel: [BarCode] = []

    required init(view: DetailViewProtocol,
                  router: RouterProtocol,
                  networkBuilder: NetworkBuilderProtocol,
                  searhModel: [Product],
                  barCodeModel: [BarCode]) {
        self.view = view
        self.router = router
        self.networkBuilder = networkBuilder
        self.searhModel = searhModel
        self.barCodeModel = barCodeModel
    }
}
