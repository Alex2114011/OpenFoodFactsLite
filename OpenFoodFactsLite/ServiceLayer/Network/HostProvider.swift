//
//  HostProvider.swift
//  OpenFoodFactsLite
//
//  Created by Alex on 28.08.2021.
//

import Foundation

protocol HostProviderProtocol {
    func getHostURL() -> URL
}

final class HostProvider: HostProviderProtocol {
   private enum Host {
        case world
    }

   private var host: Host = .world

    func getHostURL() -> URL {
        switch host {
        case .world:
            return URL(string: "https://world.openfoodfacts.org/")!
        }
    }
}
