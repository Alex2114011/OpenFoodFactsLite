//
//  BarCodeTableViewCell.swift
//  OpenFoodFactsLite
//
//  Created by Alex on 20.09.2021.
//

import UIKit

class BarCodeTableViewCell: UITableViewCell {

    @IBOutlet weak var barCodeImageView: UIImageView!
    @IBOutlet weak var barCodeTextView: UITextView!

    func updateUI(model: BarCode) {
        self.selectionStyle = .none
        barCodeTextView.isEditable = false
        barCodeTextView.isSelectable = true
        barCodeTextView.isScrollEnabled = false
        guard let barCode = model.product?.code else { return }
        barCodeTextView.text = barCode
    }
}
