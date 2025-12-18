//
//  SearchResultsViewController.swift
//  WeatherApp
//
//  Created by DO HOANG SON on 17/12/25.
//

import UIKit
import Combine

class SearchResultsViewController: UITableViewController {
    // MARK: - Private properties
    private var cancellables: Set<AnyCancellable> = []
    private let viewModel: DefaultSearchResultsViewModel
    
    private var items: [City] {
        viewModel.searchedCities
    }
    
    // MARK: - init
    init(viewModel: DefaultSearchResultsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        binding()
    }
}

// MARK: - Actions
extension SearchResultsViewController {
    func updateItems(searchTerm: String) {
        Task {
            await viewModel.searchCities(searchTerm: searchTerm)
        }
    }
}

// MARK: - Binding
extension SearchResultsViewController {
    private func binding() {
        viewModel.$searchedCities
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .store(in: &cancellables)
    }
}

// MARK: - UITableViewDataSource
extension SearchResultsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = getDisplayText(indexPath: indexPath)
        return cell
    }
    
    private func getDisplayText(indexPath: IndexPath) -> String {
        let item = items[indexPath.row]
        let name = item.name
        let country = item.country
        
        /// some cities share the same name, therefore country should be displayed
        return country.isEmpty ? name : "\(name) - \(country)"
    }
}

// MARK: - UITableViewDelegate
extension SearchResultsViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myPrint("did select item: \(items[indexPath.row].name)")
    }
}
