//
//  SearchResultsViewController.swift
//  WeatherApp
//
//  Created by DO HOANG SON on 17/12/25.
//

import UIKit
import Combine

protocol SearchResultsDelegate: AnyObject {
    func didSelectCity(_ city: City)
}

class SearchResultsViewController: UITableViewController {
    // MARK: - Properties
    private var cancellables: Set<AnyCancellable> = []
    private let viewModel: SearchResultsViewModel
    
    private var cities: [City] {
        viewModel.searchedCities
    }
    weak var delegate: SearchResultsDelegate?
    
    // MARK: - init
    init(viewModel: SearchResultsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
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
    func updateItems(searchTerm: String?) {
        guard let searchTerm else { return }
        viewModel.searchTermSubject.send(searchTerm)
    }
}

// MARK: - Binding
extension SearchResultsViewController {
    private func binding() {
        viewModel.searchedCitiesPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
}

// MARK: - UITableViewDataSource
extension SearchResultsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = getDisplayText(indexPath: indexPath)
        return cell
    }
    
    private func getDisplayText(indexPath: IndexPath) -> String {
        let item = cities[indexPath.row]
        let name = item.name
        let country = item.country
        
        /// some cities share the same name, therefore country should be displayed
        return country.isEmpty ? name : "\(name) - \(country)"
    }
}

// MARK: - UITableViewDelegate
extension SearchResultsViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = cities[indexPath.row]
        delegate?.didSelectCity(city)
    }
}
