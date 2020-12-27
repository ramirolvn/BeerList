//
//  Requestable.swift
//  NetworkPackage
//
//  Created by Ramiro Neto on 27/12/20.
//

import Foundation
import Alamofire

public enum HTTPMethodRequestable {
    case get
    case post
    case head
    case put
    case delete
}

extension HTTPMethodRequestable: RawRepresentable {
    public typealias RawValue = HTTPMethod
    
    public init?(rawValue: HTTPMethod) {
        switch rawValue {
        case HTTPMethod.get: self = .get
        case HTTPMethod.post: self = .post
        case HTTPMethod.head: self = .head
        case HTTPMethod.put: self = .put
        case HTTPMethod.delete: self = .delete
        default: return nil
        }
    }
    
    public var rawValue: RawValue {
        switch self {
        case .get: return HTTPMethod.get
        case .post: return HTTPMethod.post
        case .head: return HTTPMethod.head
        case .put: return HTTPMethod.put
        case .delete: return HTTPMethod.delete
        }
    }
}

public struct Requestable {
    public var url: URL?
    public var method: HTTPMethod
    public var hearders: [String: String]?
    public var queryParameters: [String: String]?
    public var bodyParameters: [String: Any]?
    public var timeout: TimeInterval = 10
    
    public init(method: HTTPMethod = .get) {
        self.method = method
    }
}

extension Requestable {
    var enconding: ParameterEncoding {
        return JSONEncoding.default
    }
}
