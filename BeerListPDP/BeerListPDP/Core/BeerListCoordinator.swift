//
//  BeerListCoordinator.swift
//  BeerListPDP
//
//  Created by Ramiro Neto on 27/12/20.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class BeerListCoordinator {

    // MARK: - Properties

    weak public var currentNavigationController: UINavigationController!

    // MARK: - Initializer

    func start(navigationController: UINavigationController) {
        let viewController = BeerListController.instantiate(
            storyboardName: ModulesStoryBoards.beerListController.rawValue,
                                                            bundle: Bundle.main)

        currentNavigationController = navigationController
        currentNavigationController.setViewControllers([viewController], animated: true)
    }

    internal func callBeerDetailController() {
        let viewController = BeerDetailController.instantiate(
            storyboardName: ModulesStoryBoards.beerDetailController.rawValue,
                                                              bundle: Bundle.main)

        currentNavigationController.pushViewController(viewController, animated: true)
    }

    // MARK: - Public Functions

    public func finish() {
        currentNavigationController.dismiss(animated: true, completion: nil)
    }

    internal func back() {
        currentNavigationController.popViewController(animated: true)
    }
}
