//
//  UITableViewExtension.swift
//  OpenFoodFactsLite
//
//  Created by Alex on 29.08.2021.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(cell: T.Type) {
        let name = String(describing: cell.self)
        register(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: name)
    }

    func getCell<T: UITableViewCell>(_ cell: T.Type, _ indexPath: IndexPath) -> T {
        let identifier = String(describing: cell.self)
        return dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T ?? T()
    }
}
