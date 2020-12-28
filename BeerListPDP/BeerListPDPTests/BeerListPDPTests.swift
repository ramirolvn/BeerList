//
//  BeerListPDPTests.swift
//  BeerListPDPTests
//
//  Created by Ramiro Neto on 27/12/20.
//

import XCTest
import RxCocoa
import RxSwift
@testable import BeerListPDP

class BeerListPDPTests: XCTestCase {
    var viewModel: BeerListViewModel! = BeerListViewModel(provider: BeerListPDPLocal())
    var disposeBag: DisposeBag! = DisposeBag()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSuccessFirstBeerID() throws {
        viewModel.getBeerList()
        viewModel.beersObservable.subscribe(onNext: { [unowned self] beers in
            let firstBeer = beers?[0]
            XCTAssert(firstBeer?.id == 321)
        }).disposed(by: disposeBag)
    }

    func testSuccessThirdBeerTeorAlcoolico() throws {
        viewModel.getBeerList()
        viewModel.beersObservable.subscribe(onNext: { [unowned self] beers in
            let firstBeer = beers?[2]
            XCTAssert(firstBeer?.teorAlcoolico == "\(5.0) %")
        }).disposed(by: disposeBag)
    }

}
