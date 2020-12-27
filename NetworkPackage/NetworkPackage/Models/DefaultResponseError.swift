//
//  DefaultResponseError.swift
//  NetworkPackage
//
//  Created by Ramiro Neto on 27/12/20.
//

import Foundation

public struct DefaultResponseError: Codable {
    public let httpStatusCode: Int
    public let errorCode, message: String
    public let additionalInfo: [AdditionalInfo]?
    
    public init(httpStatusCode: Int, errorCode: String, message: String, additionalInfo: [AdditionalInfo]?) {
        self.httpStatusCode = httpStatusCode
        self.errorCode = errorCode
        self.message = message
        self.additionalInfo = additionalInfo
    }
}

public struct AdditionalInfo: Codable {
    public let key, value: String
}
