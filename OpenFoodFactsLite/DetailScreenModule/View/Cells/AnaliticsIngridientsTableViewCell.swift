//
//  AnaliticsIngridientsTableViewCell.swift
//  OpenFoodFactsLite
//
//  Created by Alex on 16.09.2021.
//

import UIKit

class AnaliticsIngridientsTableViewCell: UITableViewCell {
    @IBOutlet weak var containPalmOil: UIImageView!
    @IBOutlet weak var isVegan: UIImageView!
    @IBOutlet weak var isVegaterian: UIImageView!

    func updateUI(model: BarCode) {
        self.selectionStyle = .none
        guard let attributes = model.product?.attributeGroupsEn else { return }
        attributes.forEach { attributeGroupsEn in
            attributeGroupsEn.attributes?.forEach({ attribute in
                setVeganImage(attribute)
                setContainPalmOilImage(attribute)
                setVegeterianImage(attribute)
            })
        }
    }

   private func setVeganImage(_ attribute: Attribute) {
        switch attribute.title {
        case "Non-vegan":
            self.isVegan.image = UIImage(named: "non-vegan")
        case "Vegan status unknown":
            self.isVegan.image = UIImage(named: "vegan-status-unknown")
        case "Vegan":
            self.isVegan.image = UIImage(named: "vegan")
        case "Maybe vegan":
            self.isVegan.image = UIImage(named: "maybe-vegan")
        default:
            break
        }
    }
    fileprivate func setContainPalmOilImage(_ attribute: Attribute) {
        switch attribute.title {
        case "Palm oil free":
            self.containPalmOil.image = UIImage(named: "palm-oil-free")
        case "Palm oil":
            self.containPalmOil.image = UIImage(named: "contains-palm-oil")
        case "May contain palm oil":
            self.containPalmOil.image = UIImage(named: "may-contain-palm-oil")
        case "Palm oil content unknown":
            self.containPalmOil.image = UIImage(named: "palm-oil-content-unknown")
        default:
            break
        }
    }

    private func setVegeterianImage(_ attribute: Attribute) {
        switch attribute.title {
        case "Vegetarian":
            self.isVegaterian.image = UIImage(named: "vegetarian")
        case "Non-vegetarian":
            self.isVegaterian.image = UIImage(named: "non-vegetarian")
        case "Maybe vegetarian":
            self.isVegaterian.image = UIImage(named: "maybe-vegetarian")
        case "Vegetarian status unknown":
            self.isVegaterian.image = UIImage(named: "vegetarian-status-unknown")
        default:
            break
        }
    }
}
