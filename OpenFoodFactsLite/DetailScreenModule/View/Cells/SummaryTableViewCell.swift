//
//  SummaryTableViewCell.swift
//  OpenFoodFactsLite
//
//  Created by Alex on 16.09.2021.
//

import UIKit

class SummaryTableViewCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var nameProductLabel: UILabel!
    @IBOutlet weak var manufacturerLabel: UILabel!
    @IBOutlet weak var capacityLabel: UILabel!
    @IBOutlet weak var nutriScoreImageView: UIImageView!
    @IBOutlet weak var novaImageView: UIImageView!
    @IBOutlet weak var ecoImageView: UIImageView!

    var groupImageTask: URLSessionDataTask?

    func updateUI(model: BarCode) {
        self.selectionStyle = .none
        nameProductLabel.text = model.product?.productName
        manufacturerLabel.text = model.product?.brands
        capacityLabel.text = model.product?.quantity
        ecoImageView.image = UIImage(named: "ecoscore-unknown")

        if let url = NSURL(string: model.product?.imageURL ?? "") {
            groupImageTask = ImageCache.shared.load(url: url, callback: { [weak self] (image) in
                self?.productImageView.image = image
            })
            groupImageTask?.resume()
        }

        if let nutritionGrades = model.product?.nutritionGrades {
            nutriScoreImageView.image = UIImage(named: "nutriscore-\(nutritionGrades)")
        } else {
            nutriScoreImageView.image = UIImage(named: "nutriscore-unknown")
        }

        if let ecoscoreGrade = model.product?.ecoscoreGrade {
            if ecoscoreGrade == "a" ||
                ecoscoreGrade == "b" ||
                ecoscoreGrade == "c" ||
                ecoscoreGrade == "d" ||
                ecoscoreGrade == "e" {
                ecoImageView.image = UIImage(named: "ecoscore-\(ecoscoreGrade)")
            }

        } else {
            ecoImageView.image = UIImage(named: "ecoscore-unknown")
        }

        if let novaGroup = model.product?.novaGroup {
            novaImageView.image = UIImage(named: "nova-group-\(novaGroup)")
        } else {
            novaImageView.image = UIImage(named: "nova-group-unknown")
        }
    }
}
