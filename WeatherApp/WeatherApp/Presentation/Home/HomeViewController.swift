//
//  HomeViewController.swift
//  WeatherApp
//
//  Created by DO HOANG SON on 17/12/25.
//

import UIKit

class HomeViewController: UIViewController {
    private let viewModel: HomeViewModel
    private let searchController: UISearchController
    
    private let tableView = UITableView()
    
    // MARK: - init
    init(viewModel: HomeViewModel, searchController: UISearchController) {
        self.viewModel = viewModel
        self.searchController = searchController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        myPrint("HomeViewController::viewDidLoad")
        view.backgroundColor = .white
        
        setupUI()
    }
}

// MARK: - Setup UI
extension HomeViewController {
    private func setupUI() {
        setupTableView()
        setupSearch()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupSearch() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search city"
        searchController.obscuresBackgroundDuringPresentation = false
        
        navigationItem.searchController = searchController
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = viewModel.items[indexPath.row]
        return cell
    }
}

// MARK: - UISearchResultsUpdating
extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.text ?? ""
        
        let searchController = searchController.searchResultsController as? SearchResultsViewController
        searchController?.updateItems(searchTerm: text)
    }
}
