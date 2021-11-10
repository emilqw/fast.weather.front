//
//  ServiceProfile.swift
//  FastWeather
//
//  Created by Эмиль Яйлаев on 09.11.2021.
//

import Foundation
class ServiceUser {
    static func get(token:String, completion: @escaping (ModelUser?)->()){
        let url = String(format: "http://localhost:3000/api.users.php?token=%@", arguments: [token])
        print(url)
        URLSession.shared.dataTask(with: URL(string: url)!){data, response, error in
            if let error = error{print(error)
                return
            }
            guard let data = data else { return }
            do {
                let modelUser = try JSONDecoder().decode(ModelUser.self, from: data)
                completion(modelUser)
            } catch {
                completion(nil)
            }
        }.resume()
    }
}
