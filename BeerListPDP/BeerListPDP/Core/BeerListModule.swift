//
//  BeerListModule.swift
//  BeerListPDP
//
//  Created by Ramiro Neto on 27/12/20.
//

import Foundation
import UIKit

// MARK: - BeerListModule module

public class BeerListModule {

    // MARK: - Properties

    static let shared = BeerListModule()
    let coordinator = BeerListCoordinator()
    let container  = BeerListContainer()
    
    private init() {}

    public func assembleModule(in navigationController: UINavigationController) {
        coordinator.start(navigationController: navigationController)
        
    }

    internal func goToDetail(beer: Beer) {
        container.setupBeerDetailViewModel(beer: beer)
        coordinator.callBeerDetailController()
    }
}
