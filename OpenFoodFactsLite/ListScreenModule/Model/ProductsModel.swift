//
//  Model.swift
//  OpenFoodFactsLite
//
//  Created by Alex on 27.08.2021.
//

import Foundation

// MARK: - Model
struct Products: Codable {
    let count, page, pageCount, pageSize: Int?
    let products: [Product]?
    let skip: Int?

    enum CodingKeys: String, CodingKey {
        case count, page
        case pageCount = "page_count"
        case pageSize = "page_size"
        case products, skip
    }
}

// MARK: - Product
struct Product: Codable {
    let brands, code, ecoscoreGrade: String?
    let imageFrontSmallURL, imageFrontURL, imageSmallURL, imageURL: String?
    let novaGroup: Int?
    let nutritionGrades, productName, quantity, states: String?

    enum CodingKeys: String, CodingKey {
        case brands, code
        case ecoscoreGrade = "ecoscore_grade"
        case imageFrontSmallURL = "image_front_small_url"
        case imageFrontURL = "image_front_url"
        case imageSmallURL = "image_small_url"
        case imageURL = "image_url"
        case novaGroup = "nova_group"
        case nutritionGrades = "nutrition_grades"
        case productName = "product_name"
        case quantity, states
    }
}
