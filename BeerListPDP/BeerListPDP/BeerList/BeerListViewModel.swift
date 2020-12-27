//
//  BeerListViewModel.swift
//  BeerListPDP
//
//  Created by Ramiro Neto on 27/12/20.
//

import Foundation
import RxSwift
import RxCocoa

protocol BeerListViewModelProtocol {
    func getRowsCount() -> Int
    func getBeerList()
    func getBeer(at index: Int) -> Beer?
    func testIfNeedDoAnotherRequest(at index: Int) -> Bool
    var defaultErrorObservable: BehaviorRelay<Bool?> { get }
    var beersObservable: BehaviorRelay<[Beer]?> { get }
}

class BeerListViewModel: BeerListViewModelProtocol {

    private let provider: BeerListPDP_APIProtocol
    private var currentPage: Int = 1
    var defaultErrorObservable: BehaviorRelay<Bool?> = BehaviorRelay(value: nil)
    var beersObservable: BehaviorRelay<[Beer]?> = BehaviorRelay(value: nil)

    init(provider: BeerListPDP_APIProtocol) {
        self.provider = provider
    }

    func getRowsCount() -> Int {
        return self.beersObservable.value?.count ?? 0
    }

    func getBeer(at index: Int) -> Beer? {
        guard let beers = self.beersObservable.value, index < beers.count else {
            return nil
        }
        return beers[index]
    }

    func testIfNeedDoAnotherRequest(at index: Int) -> Bool {
        guard let beers = self.beersObservable.value, beers.count-1 == index else {
            return false
        }
        return true
    }

    func getBeerList() {
        self.provider.getBeers(withPage: currentPage, completion: {[weak self] (beers, defaultError) in
            if defaultError != nil {
                self?.defaultErrorObservable.accept(true)
                self?.beersObservable.accept(nil)
                return
            }
            self?.treatSuccessBeerResponse(beers: beers)
        })
    }

    private func treatSuccessBeerResponse(beers: [Beer]?) {
        guard let beers = beers, !beers.isEmpty else {
            return
        }
        guard let loadedBeers = self.beersObservable.value else {
            self.beersObservable.accept(beers)
            self.currentPage += 1
            return
        }
        let newBeers = loadedBeers + beers
        self.beersObservable.accept(newBeers)
        self.currentPage += 1
    }
}
