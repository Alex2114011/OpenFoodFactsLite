//
//  BarCodeModel.swift
//  OpenFoodFactsLite
//
//  Created by Alex on 28.08.2021.
//

import Foundation

// MARK: - BarCode
struct BarCode: Codable {
    let code: String?
    let product: ProductOFBarCode?
    let status: Int?
    let statusVerbose: String?

    enum CodingKeys: String, CodingKey {
        case code, product, status
        case statusVerbose = "status_verbose"
    }
}

// MARK: - Product
struct ProductOFBarCode: Codable {
    let brands, code, ecoscoreGrade: String?
    let imageFrontSmallURL, imageFrontURL, imageSmallURL, imageURL: String?
    let novaGroup: Int?
    let productName, quantity, states: String?

    enum CodingKeys: String, CodingKey {
        case brands, code
        case ecoscoreGrade = "ecoscore_grade"
        case imageFrontSmallURL = "image_front_small_url"
        case imageFrontURL = "image_front_url"
        case imageSmallURL = "image_small_url"
        case imageURL = "image_url"
        case novaGroup = "nova_group"
        case productName = "product_name"
        case quantity, states
    }
}
