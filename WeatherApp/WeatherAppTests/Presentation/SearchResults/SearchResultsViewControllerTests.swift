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
    private var suit: SearchResultsViewController!

    override func setUpWithError() throws {
        viewModel = MockSearchResultsViewModel()
        suit = SearchResultsViewController(viewModel: viewModel)
        loadViewController(suit)
    }

    override func tearDownWithError() throws {
        suit = nil
    }

    func testUpdateItem() async {
        // when
        await suit.updateItems(searchTerm: searchTerm)
        
        // then
        XCTAssertTrue(viewModel.receivedSearchTerm == searchTerm)
    }
    
    func testTableView_cellForRow() {
        // given
        viewModel.searchedCities = [TestHelpers.makeCity()]
        
        // when
        let cell = suit.tableView(suit.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        
        // then
        XCTAssertTrue(cell.textLabel?.text == "Hanoi - Vietnam")
    }
    
    func testTableView_didSelectRow() {
        // given
        viewModel.searchedCities = [TestHelpers.makeCity()]
        
        // when
        suit.tableView(suit.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
    }
}
