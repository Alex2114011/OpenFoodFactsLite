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
    let id, name, warning: String?
}

// MARK: - Attribute
struct Attribute: Codable {
    let attributeDescription, descriptionShort: String?
    let iconURL: String?
    let id: String?
    let match: Double?
    let name: String?
    let status: String?
    let title: String?
    let debug: String?

    enum CodingKeys: String, CodingKey {
        case attributeDescription = "description"
        case descriptionShort = "description_short"
        case iconURL = "icon_url"
        case id, match, name, status, title, debug
    }
}

// MARK: - Nutriments
struct Nutriments: Codable {
//    let carbohydrates, carbohydrates100G: Double?
//    let carbohydratesUnit: String?
//    let carbohydratesValue, carbonFootprintFromKnownIngredients100G: Double?
//    let carbonFootprintFromKnownIngredientsProduct, energy, energyKcal, energyKcal100G: Double?
//    let energyKcalUnit: String?
//    let energyKcalValue, energy100G: Int?
//    let energyUnit: String?
//    let energyValue: Int?
    let fat, fat100G: Double?
    let fatUnit: String?
    let fatValue: Double?
//    let fruitsVegetablesNuts, fruitsVegetablesNuts100G: Int?
//    let fruitsVegetablesNutsLabel: String?
//    let fruitsVegetablesNutsServing: Int?
//    let fruitsVegetablesNutsUnit: String?
//    let fruitsVegetablesNutsValue, novaGroup, novaGroup100G, novaGroupServing: Int?
//    let nutritionScoreFr, nutritionScoreFr100G: Int?
//    let proteins, proteins100G: Double?
//    let proteinsUnit: String?
//    let proteinsValue: Double?
    let salt, salt100G: Double?
    let saltUnit: String?
    let saltValue, saturatedFat, saturatedFat100G: Double?
    let saturatedFatUnit: String?
    let saturatedFatValue: Double?
//    let sodium, sodium100G: Double?
//    let sodiumUnit: String?
//    let sodiumValue: Double?
    let sugars, sugars100G: Double?
    let sugarsUnit: String?
    let sugarsValue: Double?
//    let vitaminA, vitaminA100G: Double?
//    let vitaminALabel, vitaminAUnit: String?
//    let vitaminAValue: Int?
//    let vitaminE, vitaminE100G: Double?
//    let vitaminELabel, vitaminEUnit: String?
//    let vitaminEValue: Int?

    enum CodingKeys: String, CodingKey {
//        case carbohydrates
//        case carbohydrates100G = "carbohydrates_100g"
//        case carbohydratesUnit = "carbohydrates_unit"
//        case carbohydratesValue = "carbohydrates_value"
//        case carbonFootprintFromKnownIngredients100G = "carbon-footprint-from-known-ingredients_100g"
//        case carbonFootprintFromKnownIngredientsProduct = "carbon-footprint-from-known-ingredients_product"
//        case energy
//        case energyKcal = "energy-kcal"
//        case energyKcal100G = "energy-kcal_100g"
//        case energyKcalUnit = "energy-kcal_unit"
//        case energyKcalValue = "energy-kcal_value"
//        case energy100G = "energy_100g"
//        case energyUnit = "energy_unit"
//        case energyValue = "energy_value"
        case fat
        case fat100G = "fat_100g"
        case fatUnit = "fat_unit"
        case fatValue = "fat_value"
//        case fruitsVegetablesNuts = "fruits-vegetables-nuts"
//        case fruitsVegetablesNuts100G = "fruits-vegetables-nuts_100g"
//        case fruitsVegetablesNutsLabel = "fruits-vegetables-nuts_label"
//        case fruitsVegetablesNutsServing = "fruits-vegetables-nuts_serving"
//        case fruitsVegetablesNutsUnit = "fruits-vegetables-nuts_unit"
//        case fruitsVegetablesNutsValue = "fruits-vegetables-nuts_value"
//        case novaGroup = "nova-group"
//        case novaGroup100G = "nova-group_100g"
//        case novaGroupServing = "nova-group_serving"
//        case nutritionScoreFr = "nutrition-score-fr"
//        case nutritionScoreFr100G = "nutrition-score-fr_100g"
//        case proteins
//        case proteins100G = "proteins_100g"
//        case proteinsUnit = "proteins_unit"
//        case proteinsValue = "proteins_value"
        case salt
        case salt100G = "salt_100g"
        case saltUnit = "salt_unit"
        case saltValue = "salt_value"
        case saturatedFat = "saturated-fat"
        case saturatedFat100G = "saturated-fat_100g"
        case saturatedFatUnit = "saturated-fat_unit"
        case saturatedFatValue = "saturated-fat_value"
//        case sodium
//        case sodium100G = "sodium_100g"
//        case sodiumUnit = "sodium_unit"
//        case sodiumValue = "sodium_value"
        case sugars
        case sugars100G = "sugars_100g"
        case sugarsUnit = "sugars_unit"
        case sugarsValue = "sugars_value"
//        case vitaminA = "vitamin-a"
//        case vitaminA100G = "vitamin-a_100g"
//        case vitaminALabel = "vitamin-a_label"
//        case vitaminAUnit = "vitamin-a_unit"
//        case vitaminAValue = "vitamin-a_value"
//        case vitaminE = "vitamin-e"
//        case vitaminE100G = "vitamin-e_100g"
//        case vitaminELabel = "vitamin-e_label"
//        case vitaminEUnit = "vitamin-e_unit"
//        case vitaminEValue = "vitamin-e_value"
    }
}

