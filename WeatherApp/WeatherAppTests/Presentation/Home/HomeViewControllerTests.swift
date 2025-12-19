//
//  HomeViewControllerTests..swift
//  WeatherAppTests
//
//  Created by DO HOANG SON on 18/12/25.
//

import XCTest
@testable import WeatherApp

final class HomeViewControllerTests: XCTestCase {
    private let searchTerm = TestHelpers.searchTerm
    
    private var viewModel: MockHomeViewModel!
    private var searchResultsViewModel: MockSearchResultsViewModel!
    private var suit: HomeViewController!
    private var searchResultsController: SearchResultsViewController!
    
    override func setUpWithError() throws {
        viewModel = MockHomeViewModel()
        searchResultsViewModel = MockSearchResultsViewModel()
        
        // searchController
        searchResultsController = SearchResultsViewController(viewModel: searchResultsViewModel)
        let searchController = UISearchController(searchResultsController: searchResultsController)
        
        suit = HomeViewController(viewModel: viewModel, searchController: searchController)
        loadViewController(searchController)
        loadViewController(suit)
    }
    
    override func tearDownWithError() throws {
        searchResultsController = nil
        suit = nil
        viewModel = nil
        searchResultsViewModel = nil
    }
    
    func testTableView_cellForRow() {
        // given
        let firstItem = "firstItem"
        viewModel.items = [firstItem]
        
        // when
        let cell = suit.tableView(suit.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        
        // then
        XCTAssertTrue(cell.textLabel?.text == firstItem)
    }
    
    func testTableView_numberOfRow() {
        // given
        viewModel.items = ["firstItem", "secondItem"]
        
        // when
        let numberOfRows = suit.tableView(suit.tableView, numberOfRowsInSection: 0)
        
        // then
        XCTAssertTrue(numberOfRows == viewModel.items.count)
    }
    
    @MainActor
    func testUpdateSearchResults() async throws {
        // when
        suit.searchController.searchBar.text = searchTerm
        suit.updateSearchResults(for: suit.searchController)
        
        XCTAssertTrue(searchResultsViewModel.receivedSearchTerm == searchTerm)
    }
    
    @MainActor
    func testUpdateSearchResults_SearchTextNil() async throws {
        // when
        suit.searchController.searchBar.text = nil
        suit.updateSearchResults(for: suit.searchController)
        
        XCTAssertTrue(searchResultsViewModel.receivedSearchTerm == "")
    }
    
    @MainActor
    func testsearchResults_DidSelectCity_DelegateIsTriggered() async throws {
        searchResultsViewModel.searchedCities = [TestHelpers.makeCity()]
        
        searchResultsController.tableView(searchResultsController.tableView, didSelectRowAt: IndexPath(item: 0, section: 0))
        
        try await Task.sleep(nanoseconds: 100_000_000)
    }
}
