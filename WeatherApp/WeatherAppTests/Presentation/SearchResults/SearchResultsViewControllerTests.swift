//
//  SearchResultsViewControllerTests.swift
//  WeatherAppTests
//
//  Created by DO HOANG SON on 18/12/25.
//

import XCTest
@testable import WeatherApp

final class SearchResultsViewControllerTests: XCTestCase {
    private let searchTerm = TestHelpers.searchTerm
    private var viewModel: MockSearchResultsViewModel!
    private var sut: SearchResultsViewController!

    override func setUpWithError() throws {
        viewModel = MockSearchResultsViewModel()
        sut = SearchResultsViewController(viewModel: viewModel)
        loadViewController(sut)
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testUpdateItem() async {
        // when
        await sut.updateItems(searchTerm: searchTerm)
        
        // then
        XCTAssertTrue(viewModel.receivedSearchTerm == searchTerm)
    }
    
    func testTableView_cellForRow() {
        // given
        viewModel.searchedCities = [TestHelpers.makeCity()]
        
        // when
        let cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        
        // then
        XCTAssertTrue(cell.textLabel?.text == "Hanoi, Vietnam")
    }
    
    func testTableView_didSelectRow() {
        // given
        viewModel.searchedCities = [TestHelpers.makeCity()]
        
        // when
        sut.tableView(sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
    }
}
