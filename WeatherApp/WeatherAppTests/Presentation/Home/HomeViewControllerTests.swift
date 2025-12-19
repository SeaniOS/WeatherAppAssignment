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
    private var sut: HomeViewController!
    private var searchResultsController: SearchResultsViewController!
    
    override func setUpWithError() throws {
        viewModel = MockHomeViewModel()
        searchResultsViewModel = MockSearchResultsViewModel()
        
        // searchController
        searchResultsController = SearchResultsViewController(viewModel: searchResultsViewModel)
        let searchController = UISearchController(searchResultsController: searchResultsController)
        
        sut = HomeViewController(viewModel: viewModel, searchController: searchController)
        loadViewController(searchController)
        loadViewController(sut)
    }
    
    override func tearDownWithError() throws {
        searchResultsController = nil
        sut = nil
        viewModel = nil
        searchResultsViewModel = nil
    }
    
    func testTableView_cellForRow() {
        // given
        viewModel.cities = [TestHelpers.makeCity()]
        
        // when
        let cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        
        // then
        XCTAssertTrue(cell.textLabel?.text == "Hanoi, Vietnam")
    }
    
    func testTableView_numberOfRow() {
        // given
        viewModel.cities = [TestHelpers.makeCity(), TestHelpers.makeCity()]
        
        // when
        let numberOfRows = sut.tableView(sut.tableView, numberOfRowsInSection: 0)
        
        // then
        XCTAssertTrue(numberOfRows == viewModel.cities.count)
    }
    
    @MainActor
    func testUpdateSearchResults() async throws {
        // when
        sut.searchController.searchBar.text = searchTerm
        sut.updateSearchResults(for: sut.searchController)
        
        XCTAssertTrue(searchResultsViewModel.receivedSearchTerm == searchTerm)
    }
    
    @MainActor
    func testUpdateSearchResults_SearchTextNil() async throws {
        // when
        sut.searchController.searchBar.text = nil
        sut.updateSearchResults(for: sut.searchController)
        
        XCTAssertTrue(searchResultsViewModel.receivedSearchTerm == "")
    }
    
    @MainActor
    func testsearchResults_DidSelectCity_DelegateIsTriggered() async throws {
        searchResultsViewModel.searchedCities = [TestHelpers.makeCity()]
        
        searchResultsController.tableView(searchResultsController.tableView, didSelectRowAt: IndexPath(item: 0, section: 0))
        
        try await Task.sleep(nanoseconds: 100_000_000)
    }
}
