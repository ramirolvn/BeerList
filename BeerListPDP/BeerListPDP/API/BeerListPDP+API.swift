//
//  BeerListPDP+API.swift
//  BeerListPDP
//
//  Created by Ramiro Neto on 27/12/20.
//

import Foundation
import NetworkPackage

// MARK: - APICheckoutProtocol

protocol BeerListPDPAPIProtocol {

    func getBeers(
        at page: Int,
        completion: @escaping (_ data: [Beer]?, DefaultResponseError?) -> Void
    )
}

// MARK: - APICheckout

class BeerListPDPAPI: BeerListPDPAPIProtocol {

    // MARK: - Properties
    private let baseURL = "https://api.punkapi.com/v2/beers"

    // MARK: - Initializer

    init() {
    }

    // MARK: - Public Functions

    func getBeers(
        at page: Int,
        completion: @escaping (_ data: [Beer]?, DefaultResponseError?) -> Void
    ) {
        guard let url = URL(string: baseURL) else { return }

        var request = Requestable()
        request.method = .get
        request.url = url

        request.queryParameters = [
            "page": "\(page)"
        ]

        APIManager.baseRequest(returnModel: [Beer].self, request: request, completion: {(beers, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            completion(beers, nil)
        })
    }

}
