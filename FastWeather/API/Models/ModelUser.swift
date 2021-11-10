//
//  ModelUser.swift
//  FastWeather
//
//  Created by Эмиль Яйлаев on 09.11.2021.
//

import Foundation

struct ModelUser:Decodable{
    var id:String
    var name:String
    var surname: String
    var login:String
    var time: String
    var error: ModelError?
}
