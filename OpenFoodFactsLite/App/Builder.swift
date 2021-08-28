//
//  Builder.swift
//  OpenFoodFactsLite
//
//  Created by Alex on 27.08.2021.
//

import UIKit

protocol BuilderProtocol {
    func createMainScreenModule(router: RouterProtocol) -> UIViewController
}

class ModuleBuilder: BuilderProtocol {
    func createMainScreenModule(router: RouterProtocol) -> UIViewController {
        let networkBuilder = NetworkBuilder()
        let view = MainScreenViewController()
        let presenter = MainPresenter(view: view, networkBuilder: networkBuilder, router: router)
        view.presenter = presenter
        return view
    }
}
