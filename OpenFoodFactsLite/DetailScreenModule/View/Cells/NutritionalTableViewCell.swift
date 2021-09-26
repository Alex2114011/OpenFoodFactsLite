//
//  NutritionalTableViewCell.swift
//  OpenFoodFactsLite
//
//  Created by Alex on 18.09.2021.
//

import UIKit

class NutritionalTableViewCell: UITableViewCell {

    @IBOutlet weak var fatsImageView: UIImageView!
    @IBOutlet weak var fatsLabel: UILabel!
    @IBOutlet weak var saturatedFatsImageView: UIImageView!
    @IBOutlet weak var saturatedFatsLabel: UILabel!
    @IBOutlet weak var sugarImageView: UIImageView!
    @IBOutlet weak var sugarLabel: UILabel!
    @IBOutlet weak var saltImageView: UIImageView!
    @IBOutlet weak var saltLabel: UILabel!

    func updateUI(model: BarCode) {
        self.selectionStyle = .none
        guard let attributes = model.product?.attributeGroupsEn else { return }
        attributes.forEach { attributeGroupsEn in
            attributeGroupsEn.attributes?.forEach({ attribute in
                guard let value = model.product?.nutriments else {return}
                setFat(attribute,
                       value: value.fatValue ?? 0.0,
                       unit: value.fatUnit ?? "")
                setSaturatedFat(attribute,
                                value: value.saturatedFatValue ?? 0.0,
                                unit: value.saturatedFatUnit ?? "")
                setSugar(attribute,
                         value: value.sugarsValue ?? 0.0,
                         unit: value.sugarsUnit ?? "")
                setSalt(attribute,
                        value: value.saltValue ?? 0.0,
                        unit: value.saltUnit ?? "")
            })
        }
    }

    private func setFat(_ attribute: Attribute, value: Double, unit: String) {
        let value = value.rounded(toPlaces: 2)
        switch attribute.title {
        case "Fat in high quantity":
            self.fatsImageView.image = UIImage(named: "nutrient-level-fat-high")
            self.fatsLabel.text = "\(value)\(unit) Жиры в большом количестве"
        case "Fat in moderate quantity":
            self.fatsImageView.image = UIImage(named: "nutrient-level-fat-medium")
            self.fatsLabel.text = "\(value)\(unit) Жиры в умеренном количестве"
        case "Fat in low quantity":
            self.fatsImageView.image = UIImage(named: "nutrient-level-fat-low")
            self.fatsLabel.text = "\(value)\(unit) Жиры в малом количестве"
        case "Fat in unknown quantity":
            self.fatsImageView.image = UIImage(named: "nutrient-level-fat-unknown")
            self.fatsLabel.text = "Нет данных о содержании жиров"
        default:
            break
        }
    }

    private func setSaturatedFat(_ attribute: Attribute, value: Double, unit: String) {
        let value = value.rounded(toPlaces: 2)
        switch attribute.title {
        case "Saturated fat in high quantity":
            self.saturatedFatsImageView.image = UIImage(named: "nutrient-level-saturated-fat-high")
            self.saturatedFatsLabel.text = "\(value)\(unit) Насыщенные жиры в большом количестве"
        case "Saturated fat in moderate quantity":
            self.saturatedFatsImageView.image = UIImage(named: "nutrient-level-saturated-fat-medium")
            self.saturatedFatsLabel.text = "\(value)\(unit) Насыщенные жиры в умеренном количестве"
        case "Saturated fat in low quantity":
            self.saturatedFatsImageView.image = UIImage(named: "nutrient-level-saturated-fat-low")
            self.saturatedFatsLabel.text = "\(value)\(unit) Насыщенные жиры в малом количестве"
        case "Saturated fat in unknown quantity":
            self.saturatedFatsImageView.image = UIImage(named: "nutrient-level-saturated-fat-unknown")
            self.saturatedFatsLabel.text = "Нет данных о содержании насыщенных жиров"

        default:
            break
        }
    }

    private func setSugar(_ attribute: Attribute, value: Double, unit: String) {
        let value = value.rounded(toPlaces: 2)
        switch attribute.title {
        case "Sugars in high quantity":
            self.sugarImageView.image = UIImage(named: "nutrient-level-sugars-high")
            self.sugarLabel.text = "\(value)\(unit) Сахара в большом количестве"
        case "Sugars in moderate quantity":
            self.sugarImageView.image = UIImage(named: "nutrient-level-sugars-medium")
            self.sugarLabel.text = "\(value)\(unit) Сахара в умеренном количестве"
        case "Sugars in low quantity":
            self.sugarImageView.image = UIImage(named: "nutrient-level-sugars-low")
            self.sugarLabel.text = "\(value)\(unit) Сахара в малом количестве"
        case "Sugars in unknown quantity":
            self.sugarImageView.image = UIImage(named: "nutrient-level-sugars-unknown")
            self.sugarLabel.text = "Нет данных о содержании сахара"
        default:
            break
        }
    }

    private func setSalt(_ attribute: Attribute, value: Double, unit: String) {
        let value = value.rounded(toPlaces: 2)
        switch attribute.title {
        case "Salt in high quantity":
            self.saltImageView.image = UIImage(named: "nutrient-level-salt-high")
            self.saltLabel.text = "\(value)\(unit) Соль в большом количестве"
        case "Salt in moderate quantity":
            self.saltImageView.image = UIImage(named: "nutrient-level-salt-medium")
            self.saltLabel.text = "\(value)\(unit) Соль в умеренном количестве"
        case "Salt in low quantity":
            self.saltImageView.image = UIImage(named: "nutrient-level-salt-low")
            self.saltLabel.text = "\(value)\(unit) Соль в малом количестве"
        case "Salt in unknown quantity":
            self.saltImageView.image = UIImage(named: "nutrient-level-salt-unknown")
            self.saltLabel.text = "Нет данных о содержании соли"
        default:
            break
        }
    }
}
