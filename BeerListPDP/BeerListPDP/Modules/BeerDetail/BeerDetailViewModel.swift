//
//  BeerDetailViewModel.swift
//  BeerListPDP
//
//  Created by Ramiro Neto on 27/12/20.
//

import Foundation
protocol BeerDetailViewModelProtocol {
    var beer: Beer { get }
}

struct BeerDetailViewModel: BeerDetailViewModelProtocol {
    let beer: Beer

    init(beer: Beer) {
        self.beer = beer
    }
}
