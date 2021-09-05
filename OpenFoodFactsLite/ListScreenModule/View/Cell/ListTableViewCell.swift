//
//  ListTableViewCell.swift
//  OpenFoodFactsLite
//
//  Created by Alex on 29.08.2021.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var nameProductLabel: UILabel!
    @IBOutlet weak var manufacturerLabel: UILabel!
    @IBOutlet weak var capacityLabel: UILabel!
    @IBOutlet weak var nutriScoreImageView: UIImageView!
    @IBOutlet weak var novaImageView: UIImageView!
    @IBOutlet weak var ecoImageView: UIImageView!

    var groupImageTask: URLSessionDataTask?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func updateUI(model: Product) {
        nameProductLabel.text = model.productName
        manufacturerLabel.text = model.brands
        capacityLabel.text = model.quantity
        ecoImageView.image = UIImage(named: "ecoscore-unknown")
        if let url = NSURL(string: model.imageURL ?? "Жопа") {
            groupImageTask = ImageCache.shared.load(url: url, callback: { [weak self] (image) in
                self?.productImageView.image = image
            })
            groupImageTask?.resume()
        }

        if let nutritionGrades = model.nutritionGrades {
            nutriScoreImageView.image = UIImage(named: "nutriscore-\(nutritionGrades)")
        } else {
            nutriScoreImageView.image = UIImage(named: "nutriscore-unknown")
        }
        if let ecoscoreGrade = model.ecoscoreGrade {
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
        if let novaGroup = model.novaGroup {
            novaImageView.image = UIImage(named: "nova-group-\(novaGroup)")
        } else {
            novaImageView.image = UIImage(named: "nova-group-unknown")
        }
    }
}
