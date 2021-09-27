//
//  AnaliticsIngridientsTableViewCell.swift
//  OpenFoodFactsLite
//
//  Created by Alex on 16.09.2021.
//

import UIKit

class AnaliticsIngridientsTableViewCell: UITableViewCell {

    @IBOutlet weak var palmOilStackView: UIStackView!
    @IBOutlet weak var palmOilImageView: UIImageView!
    @IBOutlet weak var palmOilLabel: UILabel!

    @IBOutlet weak var veganStackView: UIStackView!
    @IBOutlet weak var veganImageView: UIImageView!
    @IBOutlet weak var veganLabel: UILabel!

    @IBOutlet weak var vegaterianStackView: UIStackView!
    @IBOutlet weak var vegaterianImageView: UIImageView!
    @IBOutlet weak var vegaterianLabel: UILabel!

    let colorStatusGray = UIColor(red: 0.701961, green: 0.701961, blue: 0.701961, alpha: 1)
    let colorStatusRed = UIColor(red: 1.00021, green: -0.00174431, blue: -0.00376005, alpha: 1)
    let colorStatusGreen = UIColor(red: -0.00178488, green: 0.501903, blue: 0.00538756, alpha: 1)
    let colorStatusOrange = UIColor(red: 1.00043, green: 0.400473, blue: -0.00694984, alpha: 1)

    func updateUI(model: BarCode) {
        self.selectionStyle = .none
        let cornerRadius: CGFloat = 22.5
        let viewsArray: [UIView] = [palmOilStackView,
                                    palmOilImageView,
                                    palmOilLabel,
                                    veganStackView,
                                    veganLabel,
                                    veganImageView,
                                    vegaterianStackView,
                                    vegaterianImageView,
                                    vegaterianLabel]
        for view in viewsArray {
            view.layer.cornerRadius = cornerRadius
            view.clipsToBounds = true
            if let view = view as? UILabel {
                view.textColor = .white
            }
        }

        guard let attributes = model.product?.attributeGroupsEn else { return }
        attributes.forEach { attributeGroupsEn in
            attributeGroupsEn.attributes?.forEach({ attribute in
                setVeganImage(attribute)
                setContainPalmOilImage(attribute)
                setVegeterianImage(attribute)
            })
        }
    }

    private func setContainPalmOilImage(_ attribute: Attribute) {
        switch attribute.title {
        case "Palm oil free":
            palmOilImageView.image = UIImage(named: "palm-oil-free")
            palmOilStackView.backgroundColor = colorStatusGreen
            palmOilLabel.text = "Не содержит пальмовое масло"
        case "Palm oil":
            palmOilImageView.image = UIImage(named: "contains-palm-oil")
            palmOilStackView.backgroundColor = colorStatusRed
            palmOilLabel.text = "Содержит пальмовое масло"
        case "May contain palm oil":
            palmOilImageView.image = UIImage(named: "may-contain-palm-oil")
            palmOilStackView.backgroundColor = colorStatusOrange
            palmOilLabel.text = "Может содержать пальмовое масло"
        case "Palm oil content unknown":
            palmOilImageView.image = UIImage(named: "palm-oil-content-unknown")
            palmOilStackView.backgroundColor = colorStatusGray
            palmOilLabel.text = "Содержание пальмового масла не известно"
        default:
            break
        }
    }

    private func setVeganImage(_ attribute: Attribute) {
        switch attribute.title {
        case "Vegan":
            veganImageView.image = UIImage(named: "vegan")
            veganStackView.backgroundColor = colorStatusGreen
            veganLabel.text = "Веганское"
        case "Non-vegan":
            veganImageView.image = UIImage(named: "non-vegan")
            veganStackView.backgroundColor = colorStatusRed
            veganLabel.text = "Не веганское"
        case "Maybe vegan":
            veganImageView.image = UIImage(named: "maybe-vegan")
            veganStackView.backgroundColor = colorStatusOrange
            veganLabel.text = "Возможно веганское"
        case "Vegan status unknown":
            veganImageView.image = UIImage(named: "vegan-status-unknown")
            veganStackView.backgroundColor = colorStatusGray
            veganLabel.text = "Веганский статус неизвестен"
        default:
            break
        }
    }

    private func setVegeterianImage(_ attribute: Attribute) {
        switch attribute.title {
        case "Vegetarian":
            vegaterianImageView.image = UIImage(named: "vegetarian")
            vegaterianStackView.backgroundColor = colorStatusGreen
            vegaterianLabel.text = "Вегатерианское"
        case "Non-vegetarian":
            vegaterianImageView.image = UIImage(named: "non-vegetarian")
            vegaterianStackView.backgroundColor = colorStatusRed
            vegaterianLabel.text = "Не вегатерианское"
        case "Maybe vegetarian":
            vegaterianImageView.image = UIImage(named: "maybe-vegetarian")
            vegaterianStackView.backgroundColor = colorStatusOrange
            vegaterianLabel.text = "Возможно вегатерианское"
        case "Vegetarian status unknown":
            vegaterianImageView.image = UIImage(named: "vegetarian-status-unknown")
            vegaterianStackView.backgroundColor = colorStatusGray
            vegaterianLabel.text = "Вегатерианский статус неизвестен"
        default:
            break
        }
    }
}
