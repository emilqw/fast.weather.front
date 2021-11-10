//
//  ViewController.swift
//  FastWeather
//
//  Created by Эмиль Яйлаев on 06.11.2021.
//

import UIKit
import MapKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var barButtonItem: UIBarButtonItem!
    var searchCompleter = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()
    var indexPathRow = -1
    @IBOutlet weak var searchResultsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        searchCompleter.delegate = self
        authCheck()
    }
    func authCheck(){
        if let token = ModelToken {
            ServiceUser.get(token: token) { modelUser in
                if modelUser == nil {
                    DispatchQueue.main.async { [self] in
     
                        showAlert()
                    }
                }
            }
        } else {
            showAlert()
        }
    }
    func showAlert() {
        let alert = UIAlertController(title: "Дорогой пользователь!", message: "Для начала работы с приложением, вам нужно авторизоваться!", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Авторизоваться", style: .default) { sender in
            self.tabBarController?.selectedIndex = 2
        }
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchCompleter.queryFragment = searchText
    }
}

extension SearchViewController: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        searchResultsTableView.reloadData()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        // handle error
    }
}

extension SearchViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchResult = searchResults[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.subtitle
        return cell
    }
}

extension SearchViewController: UITableViewDelegate{
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        authCheck()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let completion = searchResults[indexPath.row]
        let searchRequest = MKLocalSearch.Request(completion: completion)
        let search = MKLocalSearch(request: searchRequest)
        search.start { [self] (response, error) in
            let coordinate = response?.mapItems[0].placemark.coordinate
            if self.indexPathRow == -1 {
                tableView.selectRow(at: indexPath, animated: true,scrollPosition: .top)
                self.indexPathRow = indexPath.row
                if FavoritesStorage.search(title: completion.title, lat: coordinate?.latitude, lon: coordinate?.longitude) == -1{
                    self.barButtonItem.image = .add
                    self.barButtonItem.isEnabled = true
                    barButtonItem.action = #selector(buttonAdd)
                }else {
                    self.barButtonItem.image = .remove
                    self.barButtonItem.isEnabled = true
                    barButtonItem.action = #selector(buttonRemove)
                }
            } else {
                if self.indexPathRow == indexPath.row{
                    tableView.deselectRow(at: indexPath, animated: true)
                    self.indexPathRow = -1
                    self.barButtonItem.isEnabled = false
                    self.barButtonItem.image = .none
                } else {
                    tableView.selectRow(at: indexPath, animated: true,scrollPosition: .top)
                    self.indexPathRow = indexPath.row
                    let searchIndex = FavoritesStorage.search(title: completion.title, lat: coordinate?.latitude, lon: coordinate?.longitude)
                    if searchIndex == -1{
                        self.barButtonItem.image = .add
                        self.barButtonItem.isEnabled = true
                        barButtonItem.action = #selector(buttonAdd)
                    } else {
                        self.barButtonItem.image = .remove
                        self.barButtonItem.isEnabled = true
                        barButtonItem.action = #selector(buttonRemove)
                    }
                }
            }
            
        }
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        barButtonItem.isEnabled = false
    }
    @objc func buttonAdd(sender: UIButton!) {
        let completion = searchResults[indexPathRow]
        let searchRequest = MKLocalSearch.Request(completion: completion)
        let search = MKLocalSearch(request: searchRequest)
        search.start { [self] (response, error) in
            let coordinate = response?.mapItems[0].placemark.coordinate
            FavoritesStorage.addFavorite(title: completion.title, lat: coordinate?.latitude, lon: coordinate?.longitude)
            self.barButtonItem.image = .remove
            barButtonItem.action = #selector(buttonRemove)
        }
    }
    @objc func buttonRemove(sender: UIButton!) {
        let completion = searchResults[indexPathRow]
        let searchRequest = MKLocalSearch.Request(completion: completion)
        let search = MKLocalSearch(request: searchRequest)
        search.start { [self] (response, error) in
            let coordinate = response?.mapItems[0].placemark.coordinate
            let searchIndex = FavoritesStorage.search(title: completion.title, lat: coordinate?.latitude, lon: coordinate?.longitude)
            FavoritesStorage.removeFavorite(at: searchIndex)
            self.barButtonItem.image = .add
            barButtonItem.action = #selector(buttonAdd)
        }
    }
}
