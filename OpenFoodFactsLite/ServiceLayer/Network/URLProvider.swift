//
//  URLProvider.swift
//  OpenFoodFactsLite
//
//  Created by Alex on 28.08.2021.
//

import Foundation

protocol URLProviderProtocol {
    var searchPath: URL { get }
    var barCodePath: URL { get }
}

final class URLProvider: URLProviderProtocol {

    var searchPath: URL {
        return URL(string: "cgi/search.pl")!
    }

    var barCodePath: URL {
        return URL(string: "api/v0/product")!
    }
}
