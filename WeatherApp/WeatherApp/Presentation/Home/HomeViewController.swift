//
//  HomeViewController.swift
//  WeatherApp
//
//  Created by DO HOANG SON on 17/12/25.
//

import UIKit
import SwiftUI

class HomeViewController: UIViewController {
    private let viewModel: HomeViewModel
    let searchController: UISearchController
    let tableView = UITableView()
    
    // MARK: - init
    init(viewModel: HomeViewModel, searchController: UISearchController) {
        self.viewModel = viewModel
        self.searchController = searchController
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppConstants.ThemeColor.pantoneCloudDancerUIColor
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchCityHistories()
        tableView.reloadData()
    }
}

// MARK: - Setup UI
extension HomeViewController {
    private func setupUI() {
        self.title = "Home"
        setupTableView()
        setupSearch()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        
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
        navigationItem.hidesSearchBarWhenScrolling = false // show search bar immediately
        definesPresentationContext = true
        
        let searchResultsController = searchController.searchResultsController as? SearchResultsViewController
        searchResultsController?.delegate = self
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let city = viewModel.cities[indexPath.row]
        cell.textLabel?.text = city.displayedName
        return cell
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = viewModel.cities[indexPath.row]
        goToCity(city)
    }
}

// MARK: - UISearchResultsUpdating
extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.text
        
        let searchResultsController = searchController.searchResultsController as? SearchResultsViewController
        searchResultsController?.updateItems(searchTerm: text)
    }
}

// MARK: - SearchResultsViewControllerDelegate
extension HomeViewController: SearchResultsDelegate {
    func didSelectCity(_ city: City) {
        goToCity(city)
    }
}

extension HomeViewController {
    private func goToCity(_ city: City) {
        let cityViewController = Scene().makeCityViewController(city: city)
        navigationController?.pushViewController(cityViewController, animated: true)
    }
}
