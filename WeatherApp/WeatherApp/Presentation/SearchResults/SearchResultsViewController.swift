//
//  SearchResultsViewController.swift
//  WeatherApp
//
//  Created by DO HOANG SON on 17/12/25.
//

import UIKit

class SearchResultsViewController: UIViewController {
    var items = [String]()
    
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        setupUI()
    }
    
    func updateItems(searchText: String) {
        if searchText.trimmingCharacters(in: .whitespaces).isEmpty {
            items = []
            tableView.reloadData()
            return
        }
        
        let firstItem = "\(searchText)-1"
        let secondItem = "\(searchText)-2"
        let thirdItem = "\(searchText)-3"
        items = [firstItem, secondItem, thirdItem]
        tableView.reloadData()
    }
}

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
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SearchResultsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myPrint("did select item: \(items[indexPath.row])")
    }
}
