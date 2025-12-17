//
//  SearchResultsViewController.swift
//  WeatherApp
//
//  Created by DO HOANG SON on 17/12/25.
//

import UIKit
import Combine

class SearchResultsViewController: UIViewController {
    private var cancellables: Set<AnyCancellable> = []
    private let viewModel: SearchResultsViewModel
    
    private var items: [City] {
        viewModel.searchedCities
    }
    
    private let tableView = UITableView()
    
    // MARK: - init
    init(viewModel: SearchResultsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        setupUI()
        binding()
    }
    
    func updateItems(searchTerm: String) {
        viewModel.searchCities(searchTerm: searchTerm)
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

// MARK: - Setup UI
extension SearchResultsViewController {
    private func setupUI() {
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource
extension SearchResultsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        let item = items[indexPath.row]
        let name = item.name
        let country = item.country
        
        /// some cities share the same name, therefore country should be displayed
        cell.textLabel?.text = country.isEmpty ? name : "\(name) - \(country)"
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SearchResultsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myPrint("did select item: \(items[indexPath.row].name)")
    }
}
