//
//  SnapshotViewTest.swift
//  BeerListPDPTests
//
//  Created by Ramiro Neto on 28/12/20.
//

import XCTest
import FBSnapshotTestCase
@testable import BeerListPDP

class SnapshotViewTest: FBSnapshotTestCase {
    
    var beerList: UIViewController!
    var beerDetail: UIViewController!
    
    override func setUp() {
        super.setUp()
        beerList = BeerListController.instantiate(
            storyboardName: ModulesStoryBoards.beerListController.rawValue,
                                                            bundle: Bundle.main)
        beerDetail = BeerDetailController.instantiate(
            storyboardName: ModulesStoryBoards.beerDetailController.rawValue,
                                                            bundle: Bundle.main)
//        self.recordMode = true
    }
    
    override func tearDown() {
        super.tearDown()
        beerList = nil
        beerDetail = nil
    }
    
    func testBeerList() {
        FBSnapshotVerifyView(beerList.view)
    }
    
    func testBeerDetail() {
        FBSnapshotVerifyView(beerDetail.view)
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

}
