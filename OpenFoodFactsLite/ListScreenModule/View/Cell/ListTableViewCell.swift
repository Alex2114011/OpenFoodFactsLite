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
    @IBOutlet weak var nutriScoreImageView: UIImageView!
    @IBOutlet weak var novaImageView: UIImageView!
    @IBOutlet weak var ecoImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
