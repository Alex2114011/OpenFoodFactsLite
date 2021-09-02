//
//  ListPresenter.swift
//  OpenFoodFactsLite
//
//  Created by Alex on 29.08.2021.
//

import Foundation

protocol ListViewProtocol: AnyObject {
}

protocol ListViewPresenterProtocol: AnyObject {
    init(view: ListViewProtocol, router: RouterProtocol)
}

class ListPresenter: ListViewPresenterProtocol {
    weak var view: ListViewProtocol?
    var router: RouterProtocol?

    required init(view: ListViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
}
