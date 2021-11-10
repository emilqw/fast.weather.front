//
//  ModelAuth.swift
//  FastWeather
//
//  Created by Эмиль Яйлаев on 09.11.2021.
//

import Foundation

struct ModelAuth:Decodable{
    var token:String?
    var error:ModelError?
}

