//
//  APIManager.swift
//  NetworkPackage
//
//  Created by Ramiro Neto on 27/12/20.
//

import Foundation
import Alamofire

public class APIManager {
    
    private class func getSessionManager(request: Requestable) -> SessionManager {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TimeInterval(request.timeout)
        configuration.timeoutIntervalForResource = TimeInterval(request.timeout)
        configuration.urlCache?.removeAllCachedResponses()
        return Alamofire.SessionManager(configuration: configuration)
    }
    
    public class func baseRequest<T>(returnModel: T.Type, request: Requestable, completion: @escaping (T?, DefaultResponseError?) -> Void ) where T: Codable {
        guard let requestUrl = request.url else { return }
        guard var urlComponents = URLComponents(url: requestUrl, resolvingAgainstBaseURL: true) else { return }
        if urlComponents.queryItems == nil { urlComponents.queryItems = [] }
        urlComponents.addQueryParameters(request.queryParameters)
        guard let url = urlComponents.url else { return }
        
        var headers: HTTPHeaders?
        if let requestHeaders = request.hearders {
            headers = requestHeaders as HTTPHeaders
        }
        
        Alamofire.request(url, method: request.method, parameters: request.bodyParameters, encoding: request.enconding, headers: headers).responseJSON { response in
            switch response.result {
            case .success:
                do {
                    if response.response?.statusCode != 200 && response.response?.statusCode != 201 && response.response?.statusCode != 204 {
                        let defaultResponseError = try JSONDecoder().decode(DefaultResponseError.self, from: response.data!)
                        completion(nil, defaultResponseError)
                        return
                    }
                    let response = try JSONDecoder().decode(returnModel, from: response.data!)
                    completion(response, nil)
                } catch let error {
                    setupErrorResponse(response, error: error, completion: completion)
                }
            case .failure(let error):
                setupErrorResponse(response, error: error, completion: completion)
            }
        }
    }
    
    public class func baseRequest(request: Requestable, completion: @escaping (DataResponse<Any>?, DefaultResponseError?) -> Void) {
        guard let requestUrl = request.url else { return }
        guard var urlComponents = URLComponents(url: requestUrl, resolvingAgainstBaseURL: true) else { return }
        if urlComponents.queryItems == nil { urlComponents.queryItems = [] }
        urlComponents.addQueryParameters(request.queryParameters)
        guard let url = urlComponents.url else { return }
        
        var headers: HTTPHeaders?
        if let requestHeaders = request.hearders {
            headers = requestHeaders as HTTPHeaders
        }
        
        Alamofire.request(url, method: request.method, parameters: request.bodyParameters, encoding: request.enconding, headers: headers).responseJSON { response in
            switch response.result {
            case .success:
                if response.response?.statusCode != 200 && response.response?.statusCode != 201 && response.response?.statusCode != 204 {
                    let defaultResponseError = try? JSONDecoder().decode(DefaultResponseError.self, from: response.data!)
                    completion(nil, defaultResponseError)
                    return
                }
                completion(response, nil)
            case .failure(let error):
                setupErrorResponse(response, error: error, completion: completion)
            }
        }
    }
    
    public class func baseRequestWithExpectedErrorModel<T, G>(returnSucessModel: T.Type, returnErrorModel: G.Type, request: Requestable, completion: @escaping (T?, G?, DefaultResponseError?) -> Void ) where T: Codable, G: Codable {
        guard let requestUrl = request.url else { return }
        guard var urlComponents = URLComponents(url: requestUrl, resolvingAgainstBaseURL: true) else { return }
        if urlComponents.queryItems == nil { urlComponents.queryItems = [] }
        urlComponents.addQueryParameters(request.queryParameters)
        guard let url = urlComponents.url else { return }
        
        var headers: HTTPHeaders?
        if let requestHeaders = request.hearders {
            headers = requestHeaders as HTTPHeaders
        }
        
        Alamofire.request(url, method: request.method, parameters: request.bodyParameters, encoding: request.enconding, headers: headers).responseJSON { response in
            switch response.result {
            case .success:
                do {
                    if response.response?.statusCode != 200 && response.response?.statusCode != 201 && response.response?.statusCode != 204 {
                        let defaultResponseError = try JSONDecoder().decode(DefaultResponseError.self, from: response.data!)
                        completion(nil, nil, defaultResponseError)
                        return
                    }
                    let response = try JSONDecoder().decode(returnSucessModel, from: response.data!)
                    completion(response, nil, nil)
                } catch _ {
                    do {
                        let response = try JSONDecoder().decode(returnErrorModel, from: response.data!)
                        completion(nil, response, nil)
                    } catch let error {
                        setupErrorWithExpectedErrorModelResponse(response, error: error, completion: completion)
                    }
                }
            case .failure(let error):
                setupErrorWithExpectedErrorModelResponse(response, error: error, completion: completion)
            }
        }
    }
    
    // MARK: - Aux Functions
    
    private class func setupErrorResponse<T>(_ response: DataResponse<Any>, error: Error, completion: @escaping (T?, DefaultResponseError?) -> Void) {
        guard let statusCode = response.response?.statusCode else {
            completion(nil, nil)
            return
        }
        let defaultResponseError = DefaultResponseError(httpStatusCode: statusCode, errorCode: String(error._code), message: error.localizedDescription, additionalInfo: nil)
        completion(nil, defaultResponseError)
    }
    
    private class func setupErrorWithExpectedErrorModelResponse<T, G>(_ response: DataResponse<Any>, error: Error, completion: @escaping (T?, G?, DefaultResponseError?) -> Void) {
        guard let statusCode = response.response?.statusCode else {
            completion(nil, nil, nil)
            return
        }
        let defaultResponseError = DefaultResponseError(httpStatusCode: statusCode, errorCode: String(error._code), message: error.localizedDescription, additionalInfo: nil)
        completion(nil, nil, defaultResponseError)
    }
}
