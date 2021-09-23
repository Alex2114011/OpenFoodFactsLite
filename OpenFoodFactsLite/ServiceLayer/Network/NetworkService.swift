//
//  NetworkService.swift
//  OpenFoodFactsLite
//
//  Created by Alex on 27.08.2021.
//

import Foundation

protocol NetworkServiceProtocol {
    func sendRequest<T>(urlRequest: URLRequest?,
                        completion: @escaping ((Result<T, Error>) -> Void)) where T: Codable
}

final class BaseNetworkService: NetworkServiceProtocol {

    func sendRequest<T>(urlRequest: URLRequest?,
                        completion: @escaping ((Result<T, Error>) -> Void)) where T: Codable {

        guard let urlRequest = urlRequest else { return }

        let sessionConfiguration = URLSessionConfiguration.ephemeral
        let urlSession = URLSession(configuration: sessionConfiguration)

        urlSession.dataTask(with: urlRequest) { data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let data = data else { return }

                do {
                    _ = try JSONSerialization.jsonObject(with: data, options: [])
                    let json = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(json))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
