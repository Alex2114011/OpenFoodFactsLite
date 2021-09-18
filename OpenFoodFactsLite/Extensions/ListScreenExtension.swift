//
//  ListScreenExtension.swift
//  OpenFoodFactsLite
//
//  Created by Alex on 07.09.2021.
//

import UIKit
extension UIViewController {

    func activityStartAnimating(activityColor: UIColor, backgroundColor: UIColor) {
        let backgroundView = UIView()
        backgroundView.frame = CGRect.init(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        backgroundView.backgroundColor = backgroundColor
        backgroundView.tag = 1

        var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator = UIActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.color = activityColor
        activityIndicator.startAnimating()
        view.isUserInteractionEnabled = false
        backgroundView.addSubview(activityIndicator)
        view.addSubview(backgroundView)
    }

    func activityStopAnimating() {
        for view in self.view.subviews where view.tag == 1 {
            view.removeFromSuperview()
        }
        view.isUserInteractionEnabled = true
    }

    func addInitialView() {
        let backgroundView = UIView()
        backgroundView.frame = CGRect.init(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        backgroundView.tag = 2
        backgroundView.backgroundColor = .white

        let imageView = UIImageView()
        imageView.image = UIImage(named: "OpenFoodFactsLogo")
        backgroundView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: backgroundView.leftAnchor, constant: 50).isActive = true
        imageView.heightAnchor.constraint(equalTo: backgroundView.widthAnchor, multiplier: 3.5/5.0).isActive = true
        view.addSubview(backgroundView)
    }

    func removeInitialView() {
        for view in self.view.subviews where view.tag == 2 {
            view.removeFromSuperview()
        }
    }

    func addEmptyView() {
        let backgroundView = UIView()
        backgroundView.frame = CGRect.init(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        backgroundView.tag = 3
        backgroundView.backgroundColor = .white

        let textEmptyLabel = UILabel()
        textEmptyLabel.text = "Ни чего не нашлось 🤷"
        textEmptyLabel.textAlignment = .center
        textEmptyLabel.numberOfLines = 0
        textEmptyLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        textEmptyLabel.font = UIFont.systemFont(ofSize: 20)
        backgroundView.addSubview(textEmptyLabel)
        textEmptyLabel.translatesAutoresizingMaskIntoConstraints = false
        textEmptyLabel.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor).isActive = true
        textEmptyLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        view.addSubview(backgroundView)
    }

    func removeEmptyView() {
        for view in self.view.subviews where view.tag == 3 {
            view.removeFromSuperview()
        }
    }
}
