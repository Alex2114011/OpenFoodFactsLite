//
//  URL.swift
//  OpenFoodFactsLite
//
//  Created by Alex on 28.08.2021.
//

import Foundation

protocol URLPrepareProtocol {

    func prepareSearchRequest(url: URL,
                              parameters: [String: String]?,
                              httpMethod: HTTPMethod,
                              headerParameters: [String: String]?,
                              data: Data?) -> URLRequest?

    func prepareBarCodeRequest(url: URL,
                               barCode: String,
                               parameters: [String: String]?,
                               httpMethod: HTTPMethod,
                               headerParameters: [String: String]?,
                               data: Data?) -> URLRequest?

    init(hostProvider: HostProviderProtocol)
}

final class URLPrepare: URLPrepareProtocol {

    private let hostProvider: HostProviderProtocol

    required init(hostProvider: HostProviderProtocol) {
        self.hostProvider = hostProvider
    }

    func prepareSearchRequest(url: URL,
                              parameters: [String: String]?,
                              httpMethod: HTTPMethod,
                              headerParameters: [String: String]?,
                              data: Data?) -> URLRequest? {

        let urlWithHost = hostProvider.getHostURL().appendingPathComponent(url.absoluteString)

        guard var components = URLComponents(url: urlWithHost, resolvingAgainstBaseURL: true) else {
            return nil
        }

        if let parameters = parameters {
            components.queryItems = parameters.map({ (key: String, value: String) in
                URLQueryItem(name: key, value: value)
            })
        }

        guard let finalURL = components.url else {
            return nil
        }
        var request = URLRequest(url: finalURL)

        if let headerParams = headerParameters {
            for (key, value) in headerParams {
                request.addValue(key, forHTTPHeaderField: value)
            }
        }

        request.httpMethod = httpMethod.rawValue.uppercased()
        request.httpBody = data
        return request
    }

    func prepareBarCodeRequest(url: URL,
                               barCode: String,
                               parameters: [String: String]?,
                               httpMethod: HTTPMethod,
                               headerParameters: [String: String]?,
                               data: Data?) -> URLRequest? {

        var urlWithHost = hostProvider.getHostURL().appendingPathComponent(url.absoluteString)
        urlWithHost.appendPathComponent("\(barCode)" + ".json")

        guard var components = URLComponents(url: urlWithHost, resolvingAgainstBaseURL: true) else {
            return nil
        }
        if let parameters = parameters {
            components.queryItems = parameters.map({ (key: String, value: String) in
                URLQueryItem(name: key, value: value)
            })
        }
        guard let finalURL = components.url else {
            return nil
        }

        var request = URLRequest(url: finalURL)

        if let headerParams = headerParameters {
            for (key, value) in headerParams {
                request.addValue(key, forHTTPHeaderField: value)
            }
        }

        request.httpMethod = httpMethod.rawValue.uppercased()
        request.httpBody = data

        return request
    }
}
