//
//  ServiceWeather.swift
//  FastWeather
//
//  Created by Эмиль Яйлаев on 08.11.2021.
//

import Foundation
class ServiceWeather{
    static func get(token:String,lat:Double,lon:Double,limit:Int = 7,hours:Bool = true,extra:Bool = false,lang:String = "ru_RU", completion: @escaping (ModelWeather?)->()){
        let url = String(format: "http://localhost:3000/api.weather.php?token=%@&lat=%@&lon=%@&limit=%@&hours=%@&extra=%@&lang=%@", arguments: [token, String(describing: lat), String(describing: lon), String(describing: limit), String(describing: hours), String(describing: extra), lang])
        print(url)
        URLSession.shared.dataTask(with: URL(string: url)!){data, response, error in
            if let error = error{print(error)
                return
            }
            guard let data = data else { return }
            do {
                let modelWeather = try JSONDecoder().decode(ModelWeather.self, from: data)
                completion(modelWeather)
            } catch {
                completion(nil)
            }
        }.resume()
    }
}
