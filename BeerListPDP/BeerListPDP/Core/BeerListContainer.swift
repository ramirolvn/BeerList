//
//  BeerListContainer.swift
//  BeerListPDP
//
//  Created by Ramiro Neto on 27/12/20.
//

import Foundation
import Swinject

public class BeerListContainer {

    // MARK: - Properties

    public let container = Container()

    // MARK: - Public Methods

    public init() {
        setup()
    }

    // MARK: - Private Functions

    private func setup() {
        setupAPI()
        setupBeerListViewModel()
    }

    // MARK: - API BeerList

    private func setupAPI() {
        container.register(BeerListPDPAPIProtocol.self) { _ in
            return BeerListPDPAPI()
        }.inObjectScope(.container)
    }

    // MARK: - ViewModel

    public func setupBeerListViewModel() {
        container.register(BeerListViewModelProtocol.self) { resolver in
            let provider = resolver.resolve(BeerListPDPAPIProtocol.self)!
            return BeerListViewModel(provider: provider)
        }.inObjectScope(.container)
    }

    internal func setupBeerDetailViewModel(beer: Beer) {
        container.register(BeerDetailViewModelProtocol.self) { _ in
            return BeerDetailViewModel(beer: beer)
        }.inObjectScope(.container)
    }
}
