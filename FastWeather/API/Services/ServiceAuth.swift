//
//  ServiceAuth.swift
//  FastWeather
//
//  Created by Эмиль Яйлаев on 09.11.2021.
//

import Foundation
import Foundation
class ServiceAuth {
    static func signIn(login:String,password:String, completion: @escaping (ModelAuth?)->()){
        let url = String(format: "http://localhost:3000/api.auth.php?login=%@&password=%@&type=SignIn", arguments: [login,password])
        print(url)
        URLSession.shared.dataTask(with: URL(string: url)!){data, response, error in
            if let error = error{print(error)
                return
            }
            guard let data = data else { return }
            do {
                let modelAuth = try JSONDecoder().decode(ModelAuth.self, from: data)
                completion(modelAuth)
            } catch {
                completion(nil)
            }
        }.resume()
    }
    static func signUp(login:String,password:String, name:String,surname:String, completion: @escaping (ModelAuth?)->()){
        let url = String(format: "http://localhost:3000/api.auth.php?login=%@&password=%@&name=%@&surname=%@&type=SignUp", arguments: [login,password, name, surname])
        print(url)
        URLSession.shared.dataTask(with: URL(string: url)!){data, response, error in
            if let error = error{print(error)
                return
            }
            guard let data = data else { return }
            do {
                let modelAuth = try JSONDecoder().decode(ModelAuth.self, from: data)
                completion(modelAuth)
            } catch {
                completion(nil)
            }
        }.resume()
    }
}
