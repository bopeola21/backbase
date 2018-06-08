//
//  ViewController.swift
//  Backbase
//
//  Created by Jide Opeola on 6/7/18.
//  Copyright © 2018 Jide Opeola. All rights reserved.
//

import UIKit

class CityListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    var searchController: UISearchController?
    var filteredList: [City]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setupSearchController()
        filterListBy()
        tableView.keyboardDismissMode = .onDrag
    }
    
    func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController?.hidesNavigationBarDuringPresentation = false
        searchController?.dimsBackgroundDuringPresentation = false
        searchController?.definesPresentationContext = true
        
        searchController?.searchResultsUpdater = self
        searchController?.searchBar.delegate = self
        searchController?.delegate = self
        
        tableView.tableHeaderView = searchController?.searchBar
    }
    
    func filterListBy(_ searchText: String?=nil) {
        if searchText == "" || searchText == nil {
            filteredList = Model.shared.cities
            return
        }
        
        filteredList = filteredList?.filter({$0.name.lowercased().hasPrefix(searchText!.lowercased())})
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "cityMap",
            let destination = segue.destination as? CityMapViewController,
            let row = tableView.indexPathForSelectedRow?.row,
            let city = filteredList?[row] {
            destination.city = city
            searchController?.isActive = false
        }
    }
    
    //Unit test method
    func filteredListResult(_ searchText: String?=nil) -> [City]? {
        if searchText == "" || searchText == nil {
            return Model.shared.cities
        }
        
        return Model.shared.cities?.filter({$0.name.lowercased().hasPrefix(searchText!.lowercased())})
    }
}


//MARK:- UITableViewDelegate, UITableViewDataSource Methods
extension CityListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (filteredList?.count ?? 1)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)
        if let city = filteredList?[indexPath.row] {
            cell.textLabel?.text = "\(city.name!), \(city.country!)"
        } else {
            cell.textLabel?.text = "No cities found"
        }
        
        return cell
    }
}


//MARK:- UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating Methods
extension CityListViewController: UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterListBy(searchController.searchBar.text)
    }
}
