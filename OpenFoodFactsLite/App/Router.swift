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
            guard let mainScreenViewController = moduleBuilder?.createMainScreenModule(router: self) else { return }
            navigationController.viewControllers = [mainScreenViewController]
        }
    }

    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}
