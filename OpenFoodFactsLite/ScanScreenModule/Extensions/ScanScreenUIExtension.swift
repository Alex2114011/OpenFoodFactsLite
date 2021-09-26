//
//  ScanScreenViewControllerExtension.swift
//  OpenFoodFactsLite
//
//  Created by Alex on 24.09.2021.
//

import UIKit
// swiftlint:disable all
extension ScanScreenViewController {
    func setupRootStackView() {
        rootStackView.axis = .vertical
        rootStackView.spacing = 20
    }

    func setupEmbedStackView() {
        embedStackView.axis = .horizontal
    }

    func setupAlertLabel(text: String = "Сканирование штрих-кода продукта") {
        alertLabel.text = text
        alertLabel.textAlignment = .center
        alertLabel.backgroundColor = .gray
        alertLabel.numberOfLines = 3
        alertLabel.alpha = 0.7
        alertLabel.font = UIFont.systemFont(ofSize: 20)
        alertLabel.adjustsFontForContentSizeCategory = true
        alertLabel.translatesAutoresizingMaskIntoConstraints = false
        alertLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
    }

    func setupFlashButton() {
        flashButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        flashButton.backgroundColor = .gray
        flashButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        flashButton.setImage(UIImage(named: "flash_off"), for: .normal)
        flashButton.heightAnchor.constraint(equalTo: flashButton.widthAnchor, multiplier: 1/1).isActive = true
        flashButton.layer.cornerRadius = flashButton.bounds.width / 2
        flashButton.addTarget(self, action: #selector(flashButtonPressed(sender:)), for: .touchUpInside)
    }


    func addSubviewEmbedStackView() {
        let emtyViewOne = UIView()
        emtyViewOne.widthAnchor.constraint(equalToConstant: 10).isActive = true
        let emptyViewTwo = UIView()

        embedStackView.addArrangedSubview(emtyViewOne)
        embedStackView.addArrangedSubview(flashButton)
        embedStackView.addArrangedSubview(emptyViewTwo)
    }

    func addSubviewRootStackView() {
        rootStackView.addArrangedSubview(alertLabel)
        rootStackView.addArrangedSubview(embedStackView)
        rootStackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(rootStackView)
        rootStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        rootStackView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        rootStackView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    func setTextAlertScan() {
       DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
           self.setupAlertLabel(text: """
Не удается найти штрих-код.
Отцентрируйте штрих-код на экране.
Убедитесь, что штрих-код хорошо освещен.
""")
       }
   }

}
