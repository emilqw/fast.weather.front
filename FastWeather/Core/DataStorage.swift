//
//  DataStorage.swift
//  FastWeather
//
//  Created by Эмиль Яйлаев on 07.11.2021.
//

import Foundation
class FavoritesStorage {
    private static let key = "Favorites"
    public static var ModelFavorites:[[String:Any]]{
        set{
            UserDefaults.standard.set(newValue, forKey: FavoritesStorage.key)
            UserDefaults.standard.synchronize()
        }
        get{
            if let array = UserDefaults.standard.array(forKey: FavoritesStorage.key) as? [[String:Any]]{
                return array
            } else {
                return []
            }
        }
    }
    public static func addFavorite(title:String,lat:Double?,lon:Double?){
        guard let lat = lat else { return }
        guard let lon = lon else { return }
        ModelFavorites.append(["title": title,"lat":lat, "lon":lon])
    }
    public static func removeFavorite(at index:Int){
        if index > -1 {
            ModelFavorites.remove(at: index)
        }
    }
    public static func search(title:String,lat:Double?,lon:Double?)->Int{
        guard let lat = lat else { return -1 }
        guard let lon = lon else { return -1 }
        var index = 0
        for favorite in ModelFavorites {
            if favorite["title"] as! String == title && favorite["lat"] as! Double == lat && favorite["lon"] as! Double == lon {
                return index
            }
            index+=1
        }
        return -1
    }
    public static func removeAll(){
        ModelFavorites.removeAll()
    }
}
public var ModelToken:String?{
    set{
        UserDefaults.standard.set(newValue, forKey: "token")
        UserDefaults.standard.synchronize()
    }
    get{
        return UserDefaults.standard.string(forKey: "token")
    }
}
