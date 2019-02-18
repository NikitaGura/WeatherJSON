//
//  SearchTableViewController.swift
//  WeatherJSON
//
//  Created by Nikita Gura on 30.11.2018.
//  Copyright © 2018 Nikita Gura. All rights reserved.
//

import UIKit

class SearchTableViewController: UIViewController {
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var TableView: UITableView!
    
    private var searching = false
    private var searchedCountry = [(String)]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        TableView.delegate = self
        TableView.dataSource = self
        SearchBar.delegate = self
        SearchBar.becomeFirstResponder()
        
    
    }
    
    //Mark: -method
    private func setView(){
        TableView.alpha = 0.3
        TableView.backgroundColor = UIColor.black
        SearchBar.alpha = 0.3
        SearchBar.barTintColor = UIColor.black
        if let buttonItem = SearchBar.subviews.first?.subviews.last as? UIButton{
            buttonItem.setTitleColor(.white, for: .normal)
            buttonItem.addTarget(self, action: #selector(goBackNav), for: .touchUpInside)
        }
        self.navigationController?.navigationBar.isHidden = true
    }
    
    //Mark: -selector
    @objc func goBackNav(){
         self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.popViewController(animated: true)
    }
    
}

//Mark: -delegates

extension SearchTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchedCountry.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if searching {
            cell?.textLabel?.text = searchedCountry[indexPath.row]
        }else {
            cell?.textLabel?.text = " "
        }
        return cell!
  }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        city = searchedCountry[indexPath.row]
        print(city)
        self.navigationController?.popViewController(animated: true)
        self.navigationController?.navigationBar.isHidden = false
    }
}

extension SearchTableViewController: UISearchBarDelegate {
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedCountry = CitySingleton.city.cities.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        TableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        TableView.reloadData()
    }
    
}

