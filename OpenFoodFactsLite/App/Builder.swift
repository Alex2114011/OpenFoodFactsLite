//
//  Builder.swift
//  OpenFoodFactsLite
//
//  Created by Alex on 27.08.2021.
//

import UIKit

protocol BuilderProtocol {
    func createListScreenModule(router: RouterProtocol) -> UIViewController
    func createDetailScreenModule(router: RouterProtocol, barCode: String) -> UIViewController
}

class ModuleBuilder: BuilderProtocol {

    func createListScreenModule(router: RouterProtocol) -> UIViewController {
        let networkBuilder = NetworkBuilder()
        let view = ListScreenViewController()
        let presenter = ListPresenter(view: view,
                                      router: router,
                                      networkBuilder: networkBuilder)
        view.presenter = presenter
        return view
    }

    func createDetailScreenModule(router: RouterProtocol, barCode: String) -> UIViewController {
        let view = DetailScreenViewController()
        let networkBuilder = NetworkBuilder()
        let presenter = DetailPresenter(view: view,
                                        router: router, networkBuilder: networkBuilder, barCode: barCode)
        view.presenter = presenter
        return view
    }
}
