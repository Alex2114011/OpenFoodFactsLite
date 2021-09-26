//
//  Router.swift
//  OpenFoodFactsLite
//
//  Created by Alex on 27.08.2021.
//

import UIKit

protocol RouterMainProtocol {
    var navigationController: UINavigationController? {get set}
    var moduleBuilder: BuilderProtocol? {get set}
}

protocol RouterProtocol: RouterMainProtocol {
    func initialViewController()
    func scanViewController()
    func popToRoot()
    func showDetail(barCode: String, delegate: DetailPresenterDelegate?)
    func showDetailModal(barCode: String, delegate: DetailPresenterDelegate?)
}

class Router: RouterProtocol {

    var navigationController: UINavigationController?
    var moduleBuilder: BuilderProtocol?

    init(navigationController: UINavigationController, moduleBuilder: BuilderProtocol) {
        self.navigationController = navigationController
        self.moduleBuilder = moduleBuilder
    }

    func initialViewController() {
        if let navigationController = navigationController {
            guard let mainScreenViewController = moduleBuilder?.createListScreenModule(router: self) else { return }
            navigationController.viewControllers = [mainScreenViewController]
        }
    }

    func scanViewController() {
        if let navigationController = navigationController {
            guard let scanViewController = moduleBuilder?.createScanScreenModule(router: self) else { return }
            navigationController.viewControllers = [scanViewController]
        }
    }

    func showList() {
        if let navigationController = navigationController {
            guard let listViewController = moduleBuilder?.createListScreenModule(router: self) else {
                return }
            navigationController.pushViewController(listViewController, animated: true)
        }
    }

    func showDetail(barCode: String, delegate: DetailPresenterDelegate?) {
        if let navigationController = navigationController {
            guard let detailScreenViewController =
                    moduleBuilder?.createDetailScreenModule(router: self, barCode: barCode, delegate: delegate) else {
                return }
            navigationController.pushViewController(detailScreenViewController, animated: true)
        }
    }
    func showDetailModal(barCode: String, delegate: DetailPresenterDelegate?) {
        if let navigationController = navigationController {
            guard let detailScreenViewController =
                    moduleBuilder?.createDetailScreenModule(router: self, barCode: barCode, delegate: delegate) else {
                return }
            navigationController.present(detailScreenViewController, animated: true, completion: nil)
        }
    }

    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}
