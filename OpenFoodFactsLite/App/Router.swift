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
    func popToRoot()
    func showDetail(barCode: String)
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
    func showList() {
        if let navigationController = navigationController {
            guard let listViewController = moduleBuilder?.createListScreenModule(router: self) else {
                return }
            navigationController.pushViewController(listViewController, animated: true)
        }
    }
    func showDetail(barCode: String) {
        if let navigationController = navigationController {
            guard let detailScreenViewController =
                    moduleBuilder?.createDetailScreenModule(router: self, barCode: barCode) else {
                return }
            navigationController.pushViewController(detailScreenViewController, animated: true)
        }
    }

    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}
