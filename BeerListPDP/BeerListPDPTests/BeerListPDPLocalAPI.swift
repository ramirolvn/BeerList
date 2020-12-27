//
//  BeerListPDPLocalAPI.swift
//  BeerListPDPTests
//
//  Created by Ramiro Neto on 27/12/20.
//

import Foundation
import NetworkPackage
@testable import BeerListPDP

class BeerListPDPLocal: BeerListPDPAPIProtocol {
    
    func getBeers(at page: Int, completion: @escaping ([Beer]?, DefaultResponseError?) -> Void) {
        APIManager.loadLocalJson(returnModel: [Beer].self, with: "BeersMocked", at: Bundle.main, completion: { (beers, error) in
            completion(beers, error)
        })
    }

}
