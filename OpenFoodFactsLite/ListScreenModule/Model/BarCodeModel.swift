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
    let nutritionGrades, productName, quantity, states: String?
    let attributeGroupsEn: [AttributeGroupsEn]?
    let nutriments: Nutriments?

    enum CodingKeys: String, CodingKey {
        case brands, code
        case ecoscoreGrade = "ecoscore_grade"
        case imageFrontSmallURL = "image_front_small_url"
        case imageFrontURL = "image_front_url"
        case imageSmallURL = "image_small_url"
        case imageURL = "image_url"
        case novaGroup = "nova_group"
        case productName = "product_name"
        case nutritionGrades = "nutrition_grades"
        case quantity, states
        case attributeGroupsEn = "attribute_groups_en"
        case nutriments
    }
}

// MARK: - AttributeGroupsEn
struct AttributeGroupsEn: Codable {
    let attributes: [Attribute]?
    let id, name, warning: String? // swiftlint:disable:this identifier_name
}

// MARK: - Attribute
struct Attribute: Codable {
    let attributeDescription, descriptionShort: String?
    let iconURL: String?
    let id: String?  // swiftlint:disable:this identifier_name
    let match: Double?
    let name: String?
    let status: String?
    let title: String?
    let debug: String?

    enum CodingKeys: String, CodingKey {
        case attributeDescription = "description"
        case descriptionShort = "description_short"
        case iconURL = "icon_url"
        case id, match, name, status, title, debug  // swiftlint:disable:this identifier_name
    }
}

// MARK: - Nutriments
struct Nutriments: Codable {
    let fat, fat100G: Double?
    let fatUnit: String?
    let fatValue: Double?
    let salt, salt100G: Double?
    let saltUnit: String?
    let saltValue, saturatedFat, saturatedFat100G: Double?
    let saturatedFatUnit: String?
    let saturatedFatValue: Double?
    let sugars, sugars100G: Double?
    let sugarsUnit: String?
    let sugarsValue: Double?

    enum CodingKeys: String, CodingKey {
        case fat
        case fat100G = "fat_100g"
        case fatUnit = "fat_unit"
        case fatValue = "fat_value"
        case salt
        case salt100G = "salt_100g"
        case saltUnit = "salt_unit"
        case saltValue = "salt_value"
        case saturatedFat = "saturated-fat"
        case saturatedFat100G = "saturated-fat_100g"
        case saturatedFatUnit = "saturated-fat_unit"
        case saturatedFatValue = "saturated-fat_value"
        case sugars
        case sugars100G = "sugars_100g"
        case sugarsUnit = "sugars_unit"
        case sugarsValue = "sugars_value"
    }
}
