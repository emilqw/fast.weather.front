//
//  FavoritesViewController.swift
//  FastWeather
//
//  Created by Эмиль Яйлаев on 07.11.2021.
//

import UIKit
import SVGKit
class WeathersViewController: UITableViewController {
    var favorites:[[String:Any]] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        authCheck()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        authCheck()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let weather = favorites[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell") as! WeatherTableViewCell
        let lat = weather["lat"] as! Double
        let lon = weather["lon"] as! Double
        cell.setCity(city: String(describing: weather["title"]!))
        DispatchQueue.global().async {
            //sleep(time)
            ServiceWeather.get(token: ModelToken ?? "", lat: lat, lon: lon, limit:1, hours: false) { weathers in
                DispatchQueue.main.async {
                    if weathers != nil{
                        cell.setTemp(temp: String(describing: weathers!.fact!.temp) + " °C")
                        if let condition = Condition[weathers!.fact!.condition] {
                            cell.setCondition(condition: "Сегодня " + condition)
                            
                        }
                        cell.indicator.isHidden = true
                        cell.weatherImageView.download(from: "https://yastatic.net/weather/i/icons/funky/dark/\(weathers!.fact!.icon).svg")
                    }
                }
            }
        }
        return cell
    }
    
    @IBAction func onRefresh(_ sender: UIRefreshControl) {
        sender.endRefreshing()
        favorites = FavoritesStorage.ModelFavorites
        tableView.reloadData()
    }
    
    @IBAction func onEdit(_ sender: Any) {
        if tableView.isEditing == true {
            tableView.isEditing = false
        } else {
            tableView.isEditing = true
        }
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            FavoritesStorage.ModelFavorites.remove(at: indexPath.row)
            favorites.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    func authCheck(){
        if let token = ModelToken {
            ServiceUser.get(token: token) { modelUser in
                if let modelUser = modelUser {
                    if modelUser.error == nil {
                        DispatchQueue.main.async { [self] in
                            favorites = FavoritesStorage.ModelFavorites
                            tableView.reloadData()
                        }
                    }
                } else {
                    DispatchQueue.main.async { [self] in
                        favorites = []
                        tableView.reloadData()
                        showAlert()
                    }
                }
            }
        } else {
            favorites = []
            tableView.reloadData()
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
