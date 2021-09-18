//
//  File.swift
//  OpenFoodFactsLite
//
//  Created by Alex on 28.08.2021.
//

import Foundation

protocol SearchServiceProtocol {
    func getSearchProduct(searchText: String, page: Int,
                          completion: @escaping ((Result<Products, Error>) -> Void))
    func getBarCodeProduct(searchText: String,
                           completion: @escaping ((Result<BarCode, Error>) -> Void))
}

final class SearchService: SearchServiceProtocol {

    private let headerParameter = ["User-Agent": "LearnProject - IOS - Version 1.0 "]

    private let baseNetworkService: NetworkServiceProtocol
    private let urlProvider: URLProvider
    private let urlPrepare: URLPrepareProtocol

    init(baseNetworkService: BaseNetworkService, urlProvider: URLProvider, urlPrepare: URLPrepare ) {
        self.baseNetworkService = baseNetworkService
        self.urlProvider = urlProvider
        self.urlPrepare = urlPrepare
    }

    func getSearchProduct(searchText: String,
                          page: Int,
                          completion: @escaping ((Result<Products, Error>) -> Void)) {
        // swiftlint:disable line_length
        let parameters = ["search_terms": "\(searchText)",
                          "search_simple": "1",
                          "action": "process",
                          "json": "1",
                          "page": "\(page)",
                          "fields": "brands,code,ecoscore_alpha,ecoscore_grade,environment_impact_level_tags,image_front_url,image_front_small_url,image_small_url,image_url,nova_group,nutrition_grades,product_name,quantity,states"]

        let urlRequest = urlPrepare.prepareSearchRequest(url: urlProvider.searchPath,
                                                         parameters: parameters,
                                                         httpMethod: .get,
                                                         headerParameters: headerParameter, data: nil)
        baseNetworkService.sendRequest(urlRequest: urlRequest, completion: completion)
    }

    func getBarCodeProduct(searchText: String,
                           completion: @escaping ((Result<BarCode, Error>) -> Void)) {

        let parameters = ["fields": "brands,code,ecoscore_alpha,ecoscore_grade,environment_impact_level_tags,image_front_url,image_front_small_url,image_small_url,image_url,nova_group,nutrition_grades,product_name,quantity,states,attribute_groups_en,nutriments"]

        let urlRequest = urlPrepare.prepareBarCodeRequest(url: urlProvider.barCodePath, barCode: searchText, parameters: parameters, httpMethod: .get, headerParameters: headerParameter, data: nil)
        baseNetworkService.sendRequest(urlRequest: urlRequest, completion: completion)
    }
}
