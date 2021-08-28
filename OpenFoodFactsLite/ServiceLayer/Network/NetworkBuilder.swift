//
//  NetworkBuilder.swift
//  OpenFoodFactsLite
//
//  Created by Alex on 28.08.2021.
//

import Foundation

protocol NetworkBuilderProtocol {
    func createSearchService() -> SearchService
}

final class NetworkBuilder: NetworkBuilderProtocol {
    func createSearchService() -> SearchService {
        let baseNetworkService = BaseNetworkService()
        let urlProvider = URLProvider()
        let hostProvider = HostProvider()
        let urlPrepare = URLPrepare(hostProvider: hostProvider)
        let searchService = SearchService(baseNetworkService: baseNetworkService,
                                          urlProvider: urlProvider,
                                          urlPrepare: urlPrepare)
        return searchService
    }
}
