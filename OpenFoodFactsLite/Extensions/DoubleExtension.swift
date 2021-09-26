//
//  DoubleExtension.swift
//  OpenFoodFactsLite
//
//  Created by Alex on 26.09.2021.
//

import Foundation
extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
