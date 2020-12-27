//
//  URLComponents+Extensions.swift
//  NetworkPackage
//
//  Created by Ramiro Neto on 27/12/20.
//

import Foundation
extension URLComponents {
    
    mutating func addQueryParameters(_ queryParametersDict: [String: String]?) {
        guard let queryParametersDict = queryParametersDict else { return }
        let queryParameters = queryParametersDict.map { URLQueryItem(name: $0.key, value: $0.value) }
        queryItems?.append(contentsOf: queryParameters)
    }
}
